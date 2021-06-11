defmodule SchoolHouse.ConferencesTest do
  use ExUnit.Case

  alias SchoolHouse.{Content.Conference, Conferences}

  describe "list/0" do
    test "returns conferences ordered by date" do
      conferences = Conferences.list()

      [first_conf, second_conf | _] = conferences

      assert Date.compare(first_conf.date, second_conf.date) == :gt
    end
  end

  describe "countries/0" do
    test "countries in which conferences occur" do
      countries = Conferences.countries()

      assert is_list(countries)
      assert 1 == length(countries)
    end
  end

  describe "online/0" do
    test "returns just the online conferences" do
      online_conferences = Conferences.online()

      assert 1 == length(online_conferences)

      assert online_conferences
             |> hd()
             |> Map.get(:location)
             |> is_nil()
    end
  end

  describe "by_country/1" do
    test "returns conferences in the United States" do
      us_conferences = Conferences.by_country("United States")

      assert 1 == length(us_conferences)
      assert hd(us_conferences) |> Map.get(:country) == "United States"
    end

    test "returns empty array for conferences in Brazil" do
      brazil_conferences = Conferences.by_country("Brazil")

      assert [] == brazil_conferences
    end
  end
end
