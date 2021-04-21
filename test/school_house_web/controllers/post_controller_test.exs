defmodule SchoolHouseWeb.PostControllerTest do
  use SchoolHouseWeb.ConnCase

  describe "index/2" do
    test "renders a page of available blog posts", %{conn: conn} do
      conn = get(conn, Routes.post_path(conn, :index))
      body = html_response(conn, 200)

      assert body =~ "Title for a post"
    end
  end

  describe "show/2" do
    test "renders a page for a specific blog posts", %{conn: conn} do
      conn = get(conn, Routes.post_path(conn, :show, "test_blog_post"))
      body = html_response(conn, 200)

      assert body =~ "Title for a post"
      assert body =~ "By Sean Callan"
    end
  end
end
