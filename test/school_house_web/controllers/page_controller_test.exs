defmodule SchoolHouseWeb.PageControllerTest do
  use SchoolHouseWeb.ConnCase

  describe "get_involved/2" do
    test "renders the get involved html template", %{conn: conn} do
      conn = get(conn, Routes.page_path(conn, :get_involved, "en"))
      body = html_response(conn, 200)

      assert body =~ "Get Involved"
    end
  end
end
