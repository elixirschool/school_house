defmodule SchoolHouseWeb.LayoutView do
  use SchoolHouseWeb, :view

  def get_dark_mode_param(conn) do
    case Map.get(conn.query_params, "ui", nil) do
      "dark" -> "dark"
      _ -> ""
    end
  end
end
