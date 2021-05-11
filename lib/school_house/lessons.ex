defmodule SchoolHouse.Lessons do
  @moduledoc """
  Implements NimblePublisher and functions for retrieving lessons
  """

  alias SchoolHouse.Content.Lesson

  @ordering Application.compile_env!(:school_house, :lessons)
  @locales :school_house |> Application.compile_env!(SchoolHouseWeb.Gettext) |> Keyword.get(:locales)

  for locale <- @locales do
    path = Path.join([Application.get_env(:school_house, :lesson_dir), locale, "**/*.md"])

    contents =
      quote do
        use NimblePublisher,
          build: SchoolHouse.Content.Lesson,
          from: unquote(path),
          as: :lessons,
          highlighters: [:makeup_elixir, :makeup_erlang]

        @lesson_map Enum.into(@lessons, %{}, &{"#{&1.section}/#{&1.name}", &1})

        def get(section, name) do
          Map.get(@lesson_map, "#{section}/#{name}")
        end
      end

    __MODULE__
    |> Module.concat(String.capitalize(locale))
    |> Module.create(contents, Macro.Env.location(__ENV__))
  end

  def exists?(section, name, locale) do
    locale in @locales and nil != locale_lessons(locale).get(section, name)
  end

  defp locale_lessons(locale) do
    Module.concat(__MODULE__, String.capitalize(locale))
  end

  def get(section, name, locale) when locale in @locales do
    with nil <- locale_lessons(locale).get(section, name),
         true <- translation?(locale),
         %Lesson{} <- locale_lessons("en").get(section, name) do
      {:error, :translation_not_found}
    else
      %Lesson{} = lesson -> {:ok, populate_surrounding_lessons(lesson)}
      _ -> {:error, :not_found}
    end
  end

  def get(_section, _name, _locale) do
    {:error, :not_found}
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
    original = locale_lessons("en").get(section, name)

    case locale_lessons(locale).get(section, name) do
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
        locale_lessons(locale).get(section, lesson)
      end

    Enum.reject(lessons, &is_nil/1)
  end

  defp translation?(locale), do: "en" != locale

  defp populate_surrounding_lessons(%{locale: locale, name: name, section: section} = lesson) do
    section_lessons = @ordering[section]
    index = Enum.find_index(section_lessons, &(&1 == name))

    {previous, _} = List.pop_at(section_lessons, index - 1)
    {next, _} = List.pop_at(section_lessons, index + 1)

    previous = locale_lessons(locale).get(section, previous)
    next = locale_lessons(locale).get(section, next)

    %{lesson | previous: previous, next: next}
  end
end
