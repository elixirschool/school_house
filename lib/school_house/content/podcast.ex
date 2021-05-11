defmodule SchoolHouse.Content.Podcast do
  @moduledoc false

  @enforce_keys [:about, :active, :logo, :name, :website]
  defstruct [
    :about,
    :active,
    :language,
    :logo,
    :name,
    :website
  ]

  def build(_filename, attrs, _body) do
    struct!(__MODULE__, Map.to_list(attrs))
  end
end
