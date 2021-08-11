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
      body = html_response(conn, 404)

      assert body =~ "Page not found"
    end
  end

  describe "filter_by_tag/2" do
    test "renders a page with blog posts matching the tag", %{conn: conn} do
      conn = get(conn, Routes.post_path(conn, :filter_by_tag, "general"))
      body = html_response(conn, 200)

      assert body =~ "Posts tagged \"general\""
      assert body =~ "Title for a post"
      assert body =~ "Sean Callan"
      assert body =~ "2021-04-15"
      assert body =~ "Testing is important"
      assert body =~ "Kate Beard"
      assert body =~ "2021-08-11"
    end

    test "renders a page with an error message when no posts with the tag are found", %{conn: conn} do
      conn = get(conn, Routes.post_path(conn, :filter_by_tag, "unknown"))
      body = html_response(conn, 404)

      assert body =~ "Page not found"
    end
  end
end
