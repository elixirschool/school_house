defmodule SchoolHouse.Sponsors do
  @moduledoc """
  Fetches and caches GitHub Sponsors data for the elixirschool organization.

  Sponsor data is refreshed every 15 minutes and cached in ETS for fast reads.
  Falls back to stale cache on API errors, or returns empty data when no token is configured.
  """

  use GenServer

  require Logger

  @table :sponsors_cache
  @refresh_interval :timer.minutes(15)
  @github_graphql_url "https://api.github.com/graphql"
  @org "elixirschool"

  # Public API

  def start_link(_opts) do
    GenServer.start_link(__MODULE__, [], name: __MODULE__)
  end

  @doc "Returns all active sponsors sorted by tier (highest first)."
  def list do
    case :ets.lookup(@table, :sponsors) do
      [{:sponsors, sponsors, _ts}] -> sponsors
      [] -> []
    end
  end

  @doc "Returns sponsors at $100/month or higher tiers (homepage-worthy)."
  def featured do
    Enum.filter(list(), fn s -> s.monthly_price >= 100 end)
  end

  @doc "Returns true if there are any active sponsors."
  def any? do
    list() != []
  end

  @doc "Returns the sponsor tier definitions."
  def tiers do
    case :ets.lookup(@table, :tiers) do
      [{:tiers, tiers, _ts}] -> tiers
      [] -> default_tiers()
    end
  end

  # GenServer callbacks

  @impl true
  def init(_) do
    :ets.new(@table, [:set, :named_table, :protected, read_concurrency: true])
    {:ok, %{}, {:continue, :fetch}}
  end

  @impl true
  def handle_continue(:fetch, state) do
    fetch_and_cache()
    schedule_refresh()
    {:noreply, state}
  end

  @impl true
  def handle_info(:refresh, state) do
    fetch_and_cache()
    schedule_refresh()
    {:noreply, state}
  end

  # Private

  defp schedule_refresh do
    Process.send_after(self(), :refresh, @refresh_interval)
  end

  defp fetch_and_cache do
    case github_token() do
      token when token in [nil, ""] -> :ok
      token -> do_fetch(token)
    end
  end

  defp do_fetch(token) do
    query = """
    query($org: String!) {
      organization(login: $org) {
        sponsorshipsAsMaintainer(first: 100, activeOnly: true) {
          nodes {
            sponsorEntity {
              ... on User { login name avatarUrl websiteUrl }
              ... on Organization { login name avatarUrl websiteUrl }
            }
            tier { name monthlyPriceInDollars isOneTime }
          }
        }
        sponsorsListing {
          tiers(first: 20) {
            nodes { name monthlyPriceInDollars isOneTime description }
          }
        }
      }
    }
    """

    body = Jason.encode!(%{"query" => query, "variables" => %{"org" => @org}})

    request =
      Finch.build(
        :post,
        @github_graphql_url,
        [
          {"authorization", "bearer #{token}"},
          {"content-type", "application/json"},
          {"user-agent", "elixir-school"}
        ],
        body
      )

    case Finch.request(request, SchoolHouse.Finch, receive_timeout: 15_000) do
      {:ok, %Finch.Response{status: 200, body: response_body}} ->
        case Jason.decode(response_body) do
          {:ok, %{"data" => data}} ->
            sponsors = parse_sponsors(data)
            tiers = parse_tiers(data)
            now = System.monotonic_time(:second)
            :ets.insert(@table, {:sponsors, sponsors, now})
            :ets.insert(@table, {:tiers, tiers, now})

          {:ok, %{"errors" => errors}} ->
            Logger.warning("GitHub Sponsors API returned errors: #{inspect(errors)}")

          {:error, reason} ->
            Logger.warning("Failed to decode GitHub Sponsors response: #{inspect(reason)}")
        end

      {:ok, %Finch.Response{status: status, body: body}} ->
        Logger.warning("GitHub Sponsors API returned HTTP #{status}: #{String.slice(body, 0, 200)}")

      {:error, reason} ->
        Logger.warning("GitHub Sponsors API request failed: #{inspect(reason)}")
    end
  end

  defp parse_sponsors(data) do
    data
    |> get_in(["organization", "sponsorshipsAsMaintainer", "nodes"])
    |> Kernel.||([])
    |> Enum.map(fn node ->
      entity = node["sponsorEntity"] || %{}
      tier = node["tier"] || %{}

      %{
        login: entity["login"],
        name: entity["name"] || entity["login"],
        avatar_url: entity["avatarUrl"],
        website_url: entity["websiteUrl"],
        tier_name: tier["name"],
        monthly_price: tier["monthlyPriceInDollars"] || 0,
        one_time: tier["isOneTime"] || false
      }
    end)
    |> Enum.sort_by(& &1.monthly_price, :desc)
  end

  defp parse_tiers(data) do
    data
    |> get_in(["organization", "sponsorsListing", "tiers", "nodes"])
    |> Kernel.||([])
    |> Enum.map(fn tier ->
      %{
        name: tier["name"],
        monthly_price: tier["monthlyPriceInDollars"] || 0,
        one_time: tier["isOneTime"] || false,
        description: tier["description"] || ""
      }
    end)
    |> Enum.sort_by(& &1.monthly_price)
  end

  defp github_token do
    Application.get_env(:school_house, :github_token)
  end

  defp default_tiers do
    [
      %{
        name: "$5 a month",
        monthly_price: 5,
        one_time: false,
        description: "Help keep the lights on and lessons flowing for developers around the world."
      },
      %{
        name: "$25 a month",
        monthly_price: 25,
        one_time: false,
        description: "For developers and teams who got their start with Elixir School."
      },
      %{
        name: "$100 a month",
        monthly_price: 100,
        one_time: false,
        description: "For companies that use Elixir in production and want to invest in learning resources."
      },
      %{
        name: "$250 a month",
        monthly_price: 250,
        one_time: false,
        description: "For organizations serious about investing in Elixir education and ecosystem growth."
      },
      %{
        name: "$500 a month",
        monthly_price: 500,
        one_time: false,
        description: "Be recognized as a leader in supporting Elixir education worldwide."
      }
    ]
  end
end
