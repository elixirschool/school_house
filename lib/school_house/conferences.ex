defmodule SchoolHouse.Conferences do
  @moduledoc false

  use NimblePublisher,
    build: SchoolHouse.Content.Conference,
    from: Application.compile_env!(:school_house, :conference_dir),
    as: :conferences

  @ordered_conferences Enum.sort(@conferences, &(Date.compare(&1.date, &2.date) == :gt))
  @online Enum.filter(@ordered_conferences, &is_nil(&1.location))
  @by_countries Enum.group_by(@ordered_conferences, & &1.country)

  def list, do: @ordered_conferences

  def countries do
    list()
    |> Enum.map(& &1.country)
    |> Enum.reject(&is_nil/1)
  end

  def online, do: @online

  def by_country(country) do
    Map.get(@by_countries, country, [])
  end
end
