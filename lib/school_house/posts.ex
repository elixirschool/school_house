defmodule SchoolHouse.Posts do
  @moduledoc """
  Implements NimblePublisher and functions for retrieving blog posts
  """
  use NimblePublisher,
    build: SchoolHouse.Content.Post,
    from: "posts/*.md",
    as: :lessons,
    highlighters: [:makeup_elixir, :makeup_erlang]
end
