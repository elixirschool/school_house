defmodule SchoolHouse.Lessons do
  @moduledoc """
  Implements NimblePublisher and functions for retrieving lessons
  """
  use NimblePublisher,
    build: SchoolHouse.Content.Lesson,
    from: Application.compile_env!(:school_house, :lesson_dir),
    as: :lessons,
    highlighters: [:makeup_elixir, :makeup_erlang]

  alias SchoolHouse.Content.Lesson

  @ordering Application.compile_env(:school_house, :lessons)
  @lesson_map @lessons
              |> Enum.group_by(& &1.locale)
              |> Enum.into(%{}, fn {locale, lessons} ->
                {locale, Enum.into(lessons, %{}, &{Enum.join([&1.section, &1.name], "/"), &1})}
              end)

  def exists?(section, name, locale) do
    key = lesson_key(section, name)

    nil != get_in(@lesson_map, [locale, key])
  end

  def get(section, name, locale) do
    key = lesson_key(section, name)

    with nil <- get_in(@lesson_map, [locale, key]),
         true <- translation?(locale),
         %Lesson{} <- get_in(@lesson_map, ["en", key]) do
      {:error, :translation_not_found}
    else
      %Lesson{} = lesson -> {:ok, populate_surrounding_lessons(lesson)}
      _ -> {:error, :not_found}
    end
  end

  def translation_report(locale) do
    :school_house
    |> Application.get_env(:lessons)
    |> Enum.reduce(%{}, &section_report(&1, locale, &2))
  end

  defp section_report({section, lessons}, locale, acc) do
    lesson_statuses = Enum.map(lessons, &lesson_status(section, &1, locale))
    Map.put(acc, section, lesson_statuses)
  end

  def lesson_status(section, name, locale) do
    key = lesson_key(section, name)
    original = get_in(@lesson_map, ["en", key])

    case get_in(@lesson_map, [locale, key]) do
      nil ->
        %{lesson: nil, original: original, name: name, status: :missing}

      %Lesson{} = lesson ->
        %{lesson: lesson, original: original, name: name, status: compare_versions(lesson, original)}
    end
  end

  defp compare_versions(%{version: {translation_major, translation_minor, translation_patch}}, %{
         version: {major, minor, patch}
       }) do
    cond do
      major > translation_major -> :major
      minor > translation_minor -> :minor
      patch > translation_patch -> :patch
      true -> :complete
    end
  end

  def list(section, locale) do
    section = String.to_existing_atom(section)

    config =
      :school_house
      |> Application.get_env(:lessons)
      |> Keyword.get(section)

    lessons =
      for lesson <- config do
        key = lesson_key(section, lesson)
        get_in(@lesson_map, [locale, key])
      end

    Enum.reject(lessons, &is_nil/1)
  end

  defp translation?(locale), do: "en" != locale

  defp lesson_key(section, name), do: Enum.join([section, name], "/")

  defp populate_surrounding_lessons(%{locale: locale, name: name, section: section} = lesson) do
    section_lessons = @ordering[section]
    index = Enum.find_index(section_lessons, &(&1 == name))

    {previous, _} = List.pop_at(section_lessons, index - 1)
    {next, _} = List.pop_at(section_lessons, index + 1)

    previous = get_in(@lesson_map, [locale, lesson_key(section, previous)])
    next = get_in(@lesson_map, [locale, lesson_key(section, next)])

    %{lesson | previous: previous, next: next}
  end
end
