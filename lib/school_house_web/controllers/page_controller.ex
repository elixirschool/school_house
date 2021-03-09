defmodule SchoolHouseWeb.PageController do
  use SchoolHouseWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end

  def why(conn, _params) do
    render(conn, "why.html")
  end
end
