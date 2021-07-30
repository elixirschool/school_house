defmodule SchoolHouseWeb.LayoutViewTest do
  use SchoolHouseWeb.ConnCase, async: true

  describe "render_dark_mode?/1" do
    test "returns `dark` when dark mode query parameter is present", %{conn: conn} do
      assert conn
             |> Map.put(:query_params, %{"ui" => "dark"})
             |> SchoolHouseWeb.LayoutView.render_dark_mode?() == "dark"
    end

    test "returns `` when dark mode query parameter is not present", %{conn: conn} do
      assert conn
             |> Map.put(:query_params, %{})
             |> SchoolHouseWeb.LayoutView.render_dark_mode?() == ""
    end
  end
end
