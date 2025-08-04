defmodule SchoolHouse.Conferences do
  @moduledoc false

  use NimblePublisher,
    build: SchoolHouse.Content.Conference,
    from: Application.compile_env!(:school_house, :conference_dir),
    as: :conferences

  def list, do: ordered_conferences()

  def countries do
    list()
    |> Enum.map(& &1.country)
    |> Enum.reject(&is_nil/1)
  end

  def online, do: Enum.filter(ordered_conferences(), &is_nil(&1.location))

  def by_country(country), do: Map.get(by_countries(), country, [])

  defp ordered_conferences, do: Enum.sort(@conferences, &(Date.compare(&1.date, &2.date) == :gt))

  defp by_countries, do: Enum.group_by(ordered_conferences(), & &1.country)
end
