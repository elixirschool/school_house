defmodule SchoolHouse.Conferences do
  @moduledoc false

  use NimblePublisher,
    build: SchoolHouse.Content.Conference,
    from: Application.compile_env!(:school_house, :conference_dir),
    as: :conferences

  @online "Online"

  def list do
    @conferences
    |> Enum.sort(&(Date.compare(&1.date, &2.date) == :gt))
  end

  def countries do
    list()
    |> Enum.map(& &1.country)
    |> Enum.reject(&is_nil/1)
  end

  def online() do
    list()
    |> Enum.filter(&(&1.location == @online))
  end

  def in_person() do
    list()
    |> Enum.filter(&(&1.location != @online))
  end

  def by_country(country) do
    list()
    |> Enum.filter(&(&1.country == country))
  end
end
