defmodule SchoolHouseWeb.LayoutView do
  use SchoolHouseWeb, :view

  use PhoenixHTMLHelpers

  def render_dark_mode?(conn) do
    case conn.query_params do
      %{"ui" => "dark"} -> "dark"
      _ -> ""
    end
  end
end
