defmodule SchoolHouseWeb.ConferenceLiveIndexTest do
  use SchoolHouseWeb.ConnCase

  import Phoenix.LiveViewTest

  alias SchoolHouseWeb.ConferenceLive.IndexTestHelpers

  describe "mount/3" do
    test "can mount live view", %{conn: conn} do
      {:ok, view, html} = live_isolated(conn, SchoolHouseWeb.ConferenceLive.Index, session: %{})
      assert html =~ "Filter</p>"
    end

    test "applying country filter only returns one row", %{conn: conn} do
      {:ok, view, html} = live_isolated(conn, SchoolHouseWeb.ConferenceLive.Index, session: %{})

      filtered_view =
        IndexTestHelpers.apply_filter(view, %{filters: %{inperson: "false", online: "false", country: "United States"}})

      assert filtered_view =~ "Test In Person Conference"
      refute filtered_view =~ "Test Online Conference"
    end

    test "applying online filter only returns one row", %{conn: conn} do
      {:ok, view, html} = live_isolated(conn, SchoolHouseWeb.ConferenceLive.Index, session: %{})

      filtered_view = IndexTestHelpers.apply_filter(view, %{filters: %{inperson: "false", online: "true", country: ""}})

      refute filtered_view =~ "Test In Person Conference"
      assert filtered_view =~ "Test Online Conference"
    end

    test "applying in person filter only returns one row", %{conn: conn} do
      {:ok, view, html} = live_isolated(conn, SchoolHouseWeb.ConferenceLive.Index, session: %{})

      filtered_view = IndexTestHelpers.apply_filter(view, %{filters: %{inperson: "true", online: "false", country: ""}})

      assert filtered_view =~ "Test In Person Conference"
      refute filtered_view =~ "Test Online Conference"
    end

    test "applying in person filter and online filter returns both rows", %{conn: conn} do
      {:ok, view, html} = live_isolated(conn, SchoolHouseWeb.ConferenceLive.Index, session: %{})

      filtered_view = IndexTestHelpers.apply_filter(view, %{filters: %{inperson: "true", online: "true", country: ""}})

      assert filtered_view =~ "Test In Person Conference"
      assert filtered_view =~ "Test Online Conference"
    end

    test "applying online filter and country filter returns no rows", %{conn: conn} do
      {:ok, view, html} = live_isolated(conn, SchoolHouseWeb.ConferenceLive.Index, session: %{})

      filtered_view =
        IndexTestHelpers.apply_filter(view, %{filters: %{inperson: "false", online: "true", country: "United States"}})

      refute filtered_view =~ "Test In Person Conference"
      refute filtered_view =~ "Test Online Conference"
    end
  end
end
