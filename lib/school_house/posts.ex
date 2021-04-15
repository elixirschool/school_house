defmodule SchoolHouse.Posts do
  @moduledoc """
  Stores our posts in a module attribute and provides mechanisms to retrieve them
  """
  use NimblePublisher,
    build: SchoolHouse.Content.Post,
    from: Application.compile_env!(:school_house, :blog_dir),
    as: :posts,
    highlighters: [:makeup_elixir, :makeup_erlang]

  @paged_posts @posts |> Enum.sort(&(Date.compare(&1.date, &2.date) == :gt)) |> Enum.chunk_every(20)
  @posts_by_slug Enum.into(@posts, %{}, fn %{slug: slug} = post ->
                   {slug, post}
                 end)

  def get(slug), do: Map.get(@posts_by_slug, slug)

  def page(n), do: Enum.at(@paged_posts, n)

  def pages, do: Enum.count(@paged_posts)
end
