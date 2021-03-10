defmodule SchoolHouseWeb.PageController do
  use SchoolHouseWeb, :controller

  alias SchoolHouse.Posts

  def index(conn, _params) do
    render(conn, "index.html", posts: recent_posts)
  end

  def why(conn, _params) do
    render(conn, "why.html")
  end

  defp recent_posts do
    0
    |> Posts.page()
    |> Enum.take(2)
  end
end
