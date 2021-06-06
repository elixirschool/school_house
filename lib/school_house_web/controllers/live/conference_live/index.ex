defmodule SchoolHouseWeb.ConferenceLive.Index do
  @moduledoc false

  use SchoolHouseWeb, :live_view

  alias SchoolHouse.Conferences

  @impl true
  def mount(_params, session, socket) do
    conferences = Conferences.list()
    filters = default_filters()
    countries = countries()

    new_socket =
      socket
      |> assign(:conferences, conferences)
      |> assign(:filters, filters)
      |> assign(:countries, countries)

    {:ok, new_socket}
  end

  @impl true
  def handle_event("filter", params, socket) do
    filters = update_filters(params, socket.assigns.filters)
    conferences = query_conferences(filters)

    new_socket =
      socket
      |> assign(:conferences, conferences)
      |> assign(:filters, filters)

    {:noreply, new_socket}
  end

  defp update_filters(%{"filters" => new_filter}, filters) do
    atomized = for {key, val} <- new_filter, into: %{}, do: {String.to_atom(key), val}

    Map.merge(filters, atomized)
  end

  defp default_filters() do
    %{online: "false", inperson: "false", country: ""}
  end

  defp countries do
    Conferences.countries()
    |> Enum.into(%{}, fn x -> {x, x} end)
  end

  defp query_conferences(%{country: "", online: "false", inperson: "true"}) do
    Conferences.in_person()
  end

  defp query_conferences(%{country: "", online: "true", inperson: "false"}) do
    Conferences.online()
  end

  defp query_conferences(%{country: "", online: _, inperson: _}) do
    Conferences.list()
  end

  defp query_conferences(%{country: country, online: "true", inperson: "false"}) do
    []
  end

  defp query_conferences(%{country: country, online: _, inperson: _}) do
    Conferences.by_country(country)
  end
end
