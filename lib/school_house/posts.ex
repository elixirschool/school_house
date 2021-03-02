defmodule SchoolHouse.Posts do
  @moduledoc """
  Stores our posts in a module attribute and provides mechanisms to retrieve them
  """
  use NimblePublisher,
    build: SchoolHouse.Content.Post,
    from: "content/posts/**/*.md",
    as: :posts,
    highlighters: [:makeup_elixir, :makeup_erlang]

  @sorted_posts Enum.sort(@posts, &(&1.date > &2.date))
  @posts_by_slug Enum.into(@posts, %{}, fn %{slug: slug} = post ->
                   {slug, post}
                 end)

  def recent, do: Enum.take(@sorted_posts, 10)

  def get(slug), do: Map.get(@posts_by_slug, slug)
end
