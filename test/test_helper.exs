ExUnit.start()

defmodule SchoolHouseWeb.ConferencesLive.TestHelpers do
  import Phoenix.LiveViewTest

  def apply_filter(view, filters) do
    view
    |> element("form")
    |> render_change(filters)
  end
end
