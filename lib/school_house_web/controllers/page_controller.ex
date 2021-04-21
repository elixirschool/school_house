defmodule SchoolHouseWeb.PageController do
  use SchoolHouseWeb, :controller

  alias SchoolHouse.{Lessons, Posts}

  def index(conn, _params) do
    render(conn, "index.html", posts: recent_posts())
  end

  def privacy(conn, _params) do
    render(conn, "privacy.html")
  end

  def report(conn, %{"locale" => locale}) do
    render(conn, "report.html", report: Lessons.translation_report(locale))
  end

  def why(conn, _params) do
    render(conn, "why.html")
  end

  defp recent_posts do
    0
    |> Posts.page()
    |> Enum.take(6)
  end
end
