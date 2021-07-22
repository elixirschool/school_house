defmodule SchoolHouseWeb.ConferencesLiveTest do
  use SchoolHouseWeb.ConnCase

  import Phoenix.LiveViewTest

  alias SchoolHouseWeb.ConferencesLive.TestHelpers

  describe "mount/3" do
    test "can mount live view", %{conn: conn} do
      {:ok, _view, html} = live_isolated(conn, SchoolHouseWeb.ConferencesLive, session: %{})
      assert html =~ "Filter</p>"
    end

    test "applying no filters returns both rows", %{conn: conn} do
      {:ok, view, _html} = live_isolated(conn, SchoolHouseWeb.ConferencesLive, session: %{})

      filtered_view = TestHelpers.apply_filter(view, %{filters: %{"online" => "false", "country" => ""}})

      assert filtered_view =~ "Test In Person Conference"
      assert filtered_view =~ "Test Online Conference"
    end

    test "applying country filter only returns one row", %{conn: conn} do
      {:ok, view, _html} = live_isolated(conn, SchoolHouseWeb.ConferencesLive, session: %{})

      filtered_view = TestHelpers.apply_filter(view, %{filters: %{"online" => "false", "country" => "United States"}})

      assert filtered_view =~ "Test In Person Conference"
      refute filtered_view =~ "Test Online Conference"
    end

    test "applying online filter only returns one row", %{conn: conn} do
      {:ok, view, _html} = live_isolated(conn, SchoolHouseWeb.ConferencesLive, session: %{})

      filtered_view = TestHelpers.apply_filter(view, %{filters: %{"online" => "true", "country" => ""}})

      refute filtered_view =~ "Test In Person Conference"
      assert filtered_view =~ "Test Online Conference"
    end

    test "applying online filter and country filter returns combined set of rows", %{conn: conn} do
      {:ok, view, _html} = live_isolated(conn, SchoolHouseWeb.ConferencesLive, session: %{})

      filtered_view = TestHelpers.apply_filter(view, %{filters: %{"online" => "true", "country" => "United States"}})

      assert filtered_view =~ "Test In Person Conference"
      assert filtered_view =~ "Test Online Conference"
    end
  end
end
