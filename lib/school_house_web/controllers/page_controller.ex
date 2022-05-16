defmodule SchoolHouseWeb.PageController do
  use SchoolHouseWeb, :controller

  alias SchoolHouse.{Lessons, Podcasts, Posts}

  def index(conn, _params) do
    render(conn, "index.html", page_title: gettext("Home"), posts: recent_posts())
  end

  def podcasts(conn, _params) do
    render(conn, "podcasts.html", page_title: gettext("Podcasts"), podcasts: Podcasts.list())
  end

  def privacy(conn, _params) do
    render(conn, "privacy.html", page_title: gettext("Privacy Policy"))
  end

  def report(conn, %{"locale" => locale}) do
    render(conn, "report.html", page_title: gettext("Translation Report"), report: Lessons.translation_report(locale))
  end

  def why(conn, _params) do
    render(conn, "why.html", page_title: gettext("Why Choose Elixir?"))
  end

  def get_involved(conn, _params) do
    render(conn, "get_involved.html", page_title: gettext("Get Involved"))
  end

  defp recent_posts do
    0
    |> Posts.page()
    |> Enum.take(6)
  end
end
