defmodule ElixirschoolWeb.PageController do
  use ElixirschoolWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
