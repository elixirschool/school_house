defmodule SchoolHouseWeb.FallbackController do
  use SchoolHouseWeb, :controller

  alias SchoolHouseWeb.ErrorView

  def call(conn, {:error, :not_found}) do
    conn
    |> put_status(404)
    |> put_view(ErrorView)
    |> render("404.html")
  end

  def call(conn, {:error, :translation_not_found, missing_locale}) do
    conn
    |> put_status(404)
    |> put_view(ErrorView)
    |> assign(:missing_locale, missing_locale)
    |> render("translation_missing.html")
  end
end
