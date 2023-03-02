defmodule SchoolHouseWeb.LessonControllerTest do
  use SchoolHouseWeb.ConnCase

  @routes_map %{
    {"basics", "pattern-matching"} => {"basics", "pattern_matching"},
    {"basics", "control-structures"} => {"basics", "control_structures"},
    {"basics", "pipe-operator"} => {"basics", "pipe_operator"},
    {"basics", "date-time"} => {"basics", "date_time"},
    {"basics", "mix-tasks"} => {"intermediate", "mix_tasks"},
    {"basics", "iex-helpers"} => {"basics", "iex_helpers"},
    {"basics", "testing"} => {"testing", "basics"},
    {"advanced", "erlang"} => {"intermediate", "erlang"},
    {"advanced", "error-handling"} => {"intermediate", "error_handling"},
    {"advanced", "escripts"} => {"intermediate", "escripts"},
    {"advanced", "concurrency"} => {"intermediate", "concurrency"},
    {"advanced", "otp-concurrency"} => {"advanced", "otp_concurrency"},
    {"advanced", "otp-supervisors"} => {"advanced", "otp_supervisors"},
    {"advanced", "otp-distribution"} => {"advanced", "otp_distribution"},
    {"advanced", "umbrella-projects"} => {"advanced", "umbrella_projects"},
    {"advanced", "gen-stage"} => {"data_processing", "genstage"},
    {"ecto", "querying"} => {"ecto", "querying_basics"},
    {"specifics", "plug"} => {"misc", "plug"},
    {"specifics", "eex"} => {"misc", "eex"},
    {"specifics", "ets"} => {"storage", "ets"},
    {"specifics", "mnesia"} => {"storage", "mnesia"},
    {"specifics", "debugging"} => {"misc", "debugging"},
    {"specifics", "nerves"} => {"misc", "nerves"},
    {"libraries", "guardian"} => {"misc", "guardian"},
    {"libraries", "poolboy"} => {"misc", "poolboy"},
    {"libraries", "benchee"} => {"misc", "benchee"},
    {"libraries", "bypass"} => {"testing", "bypass"},
    {"libraries", "distillery"} => {"misc", "distillery"},
    {"libraries", "stream-data"} => {"testing", "stream_data"},
    {"libraries", "nimble-publisher"} => {"misc", "nimble_publisher"},
    {"libraries", "mox"} => {"testing", "mox"}
  }

  describe "lesson/2" do
    test "renders a page for the requested lesson", %{conn: conn} do
      conn = get(conn, Routes.lesson_path(conn, :lesson, "en", "basics", "basics"))
      body = html_response(conn, 200)

      assert body =~ "Getting Started"
    end

    test "renders a 404 for invalid lessons", %{conn: conn} do
      conn = get(conn, Routes.lesson_path(conn, :lesson, "en", "non", "existent"))
      body = html_response(conn, 404)

      assert body =~ "Page not found"
    end

    test "renders a CTA for missing translations", %{conn: conn} do
      conn = get(conn, Routes.lesson_path(conn, :lesson, "es", "basics", "enum"))
      body = html_response(conn, 404)

      assert body =~ "Traducción no disponible"
    end

    test "renders 404 for invalid locale", %{conn: conn} do
      conn = get(conn, Routes.page_path(conn, :index, "klingon"))
      body = html_response(conn, 404)

      assert body =~ "Page not found"
    end

    test "redirects old routes to new routes", %{conn: conn} do
      Enum.each(@routes_map, fn {{section, name}, {new_section, new_name}} ->
        conn = get(conn, Routes.lesson_path(conn, :lesson, "en", section, name))

        assert %{section: ^new_section, name: ^new_name} = redirected_params(conn)
      end)
    end
  end
end
