defmodule SchoolHouseWeb.ConferenceLive do
  @moduledoc false

  use SchoolHouseWeb, :live_view

  alias SchoolHouse.Conferences

  @impl true
  def mount(_params, _session, socket) do
    conferences = Conferences.list()
    filters = default_filters()
    country_options = country_options()

    new_socket =
      socket
      |> assign(:conferences, conferences)
      |> assign(:filters, filters)
      |> assign(:country_options, country_options)

    {:ok, new_socket}
  end

  @impl true
  def handle_event("filter", params, socket) do
    filters = update_filters(params, socket.assigns.filters)
    conferences = filtered_conferences(filters)

    new_socket =
      socket
      |> assign(:conferences, conferences)
      |> assign(:filters, filters)

    {:noreply, new_socket}
  end

  defp update_filters(%{"filters" => new_filter}, filters) do
    Map.merge(filters, new_filter)
  end

  defp default_filters do
    %{"online" => "false", "country" => ""}
  end

  defp country_options do
    Conferences.countries()
    |> Enum.into(%{}, fn x -> {x, x} end)
    |> Enum.concat(-: "")
    |> Enum.reverse()
  end

  defp filtered_conferences(%{"online" => "false", "country" => ""}) do
    Conferences.list()
  end

  defp filtered_conferences(filters) do
    filters
    |> Map.to_list()
    |> Enum.flat_map(&conference_filters/1)
    |> Enum.uniq()
  end

  defp conference_filters({"country", ""}) do
    []
  end

  defp conference_filters({"country", country}) do
    Conferences.by_country(country)
  end

  defp conference_filters({"online", "true"}) do
    Conferences.online()
  end

  defp conference_filters(_) do
    []
  end

  defp filter_is_online?(%{"online" => "true"}), do: true
  defp filter_is_online?(%{"online" => _}), do: false

  defp country_filter(%{"country" => ""}), do: nil
  defp country_filter(%{"country" => country}), do: country
end
