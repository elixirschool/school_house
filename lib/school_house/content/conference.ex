defmodule SchoolHouse.Content.Conference do
  @moduledoc false

  @enforce_keys [:name, :link, :date, :location]
  defstruct [
    :name,
    :series,
    :link,
    :date,
    :location,
    :country
  ]

  def build(_filename, attrs, _body) do
    struct!(__MODULE__, Map.to_list(attrs))
  end
end
