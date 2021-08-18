defmodule SchoolHouse.Posts do
  @moduledoc """
  Stores our posts in a module attribute and provides mechanisms to retrieve them
  """
  alias SchoolHouse.Content.Post

  use NimblePublisher,
    build: Post,
    from: Application.compile_env!(:school_house, :blog_dir),
    as: :posts,
    highlighters: [:makeup_elixir, :makeup_erlang]

  @paged_posts @posts |> Enum.sort(&(Date.compare(&1.date, &2.date) == :gt)) |> Enum.chunk_every(20)
  @posts_by_slug Enum.into(@posts, %{}, fn %{slug: slug} = post ->
                   {slug, post}
                 end)

  def get(slug) do
    case Map.get(@posts_by_slug, slug) do
      nil -> {:error, :not_found}
      %Post{} = post -> {:ok, post}
    end
  end

  def get_by_tag(tag) do
    tag = String.downcase(tag)

    case Enum.filter(@posts, &filter_by_tag(&1, tag)) do
      [] -> {:error, :not_found}
      posts -> {:ok, posts}
    end
  end

  defp filter_by_tag(post, tag) do
    Map.get(post, :tags, [])
    |> Enum.map(&String.downcase/1)
    |> Enum.member?(tag)
  end

  def page(n), do: Enum.at(@paged_posts, n)

  def pages, do: Enum.count(@paged_posts)

  def tag_cloud do
    Enum.reduce(@posts, %{}, fn %{tags: tags}, acc ->
      Enum.reduce(tags, acc, fn tag, accc ->
        count = Map.get(accc, tag, 0) + 1
        Map.put(accc, tag, count)
      end)
    end)
  end
end
