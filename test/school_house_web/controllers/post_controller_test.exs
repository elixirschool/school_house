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

    test "renders a page with an error message when the blog post is not found", %{conn: conn} do
      conn = get(conn, Routes.post_path(conn, :show, "test_no_post_found"))
      body = html_response(conn, 200)

      assert body =~ "Sorry, we couldn&apos;t find the post you are looking for."
      refute body =~ "By Sean Callan"
    end
  end
end
