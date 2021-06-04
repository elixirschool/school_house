defmodule SchoolHouseWeb.ConferenceLive.Index do
  use SchoolHouseWeb, :live_view

  @impl true
  def mount(_params, session, socket) do
    conferences = SchoolHouse.Conferences.list()

    new_socket = assign(socket, :conferences, conferences)

    {:ok, new_socket}
  end
end
