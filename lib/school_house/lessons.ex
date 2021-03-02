defmodule SchoolHouse.Lessons do
  @moduledoc """
  Implements NimblePublisher and functions for retrieving lessons
  """
  use NimblePublisher,
    build: SchoolHouse.Content.Lesson,
    from: "content/lessons/**/*.md",
    as: :lessons,
    highlighters: [:makeup_elixir, :makeup_erlang]

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

    @lesson_map
    |> get_in([locale, key])
    |> populate_surrounding_lessons()
  end

  defp lesson_key(section, name), do: Enum.join([section, name], "/")

  defp populate_surrounding_lessons(nil) do
    nil
  end

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
