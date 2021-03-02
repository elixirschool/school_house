defmodule SchoolHouseWeb.PageController do
  use SchoolHouseWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
