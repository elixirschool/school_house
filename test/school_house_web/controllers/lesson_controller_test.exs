defmodule SchoolHouseWeb.LessonControllerTest do
  use SchoolHouseWeb.ConnCase

  describe "lesson/2" do
    test "renders a page for the requested lesson", %{conn: conn} do
      conn = get(conn, Routes.lesson_path(conn, :lesson, "en", "basics", "basics"))
      body = html_response(conn, 200)

      assert body =~ "Getting Started"
    end

    test "renders a 404 for invalid lessons", %{conn: conn} do
      conn = get(conn, Routes.lesson_path(conn, :lesson, "en", "non", "existant"))
      body = html_response(conn, 404)

      assert body =~ "Page not found"
    end

    test "renders a CTA for missing translations", %{conn: conn} do
      conn = get(conn, Routes.lesson_path(conn, :lesson, "es", "basics", "enum"))
      body = html_response(conn, 404)

      assert body =~ "Translation unavailable"
    end

    test "renders 404 for invalid locale", %{conn: conn} do
      conn = get(conn, Routes.page_path(conn, :index, "klingon"))
      body = html_response(conn, 404)

      assert body =~ "Page not found"
    end
  end
end
