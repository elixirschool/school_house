defmodule SchoolHouseWeb.LayoutView do
  use SchoolHouseWeb, :view

  import Phoenix.Component

  def render_dark_mode?(conn) do
    case Map.get(conn.query_params, "ui", nil) do
      "dark" -> "dark"
      _ -> ""
    end
  end
end
