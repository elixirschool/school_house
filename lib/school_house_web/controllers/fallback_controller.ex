defmodule SchoolHouseWeb.FallbackController do
  use SchoolHouseWeb, :controller

  alias SchoolHouseWeb.ErrorView

  def call(conn, {:error, :not_found}) do
    conn
    |> put_status(404)
    |> put_view(ErrorView)
    |> render("404.html")
  end

  def call(conn, {:error, :translation_not_found}) do
    conn
    |> put_status(404)
    |> put_view(ErrorView)
    |> render("translation_missing.html")
  end
end
