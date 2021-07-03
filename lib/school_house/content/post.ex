defmodule SchoolHouse.Content.Post do
  @moduledoc """
  Encapsulates an individual post and handles parsing the originating markdown file
  """

  @enforce_keys [:author, :author_link, :body, :date, :excerpt, :slug, :tags, :title]
  defstruct [
    :author,
    :author_link,
    :body,
    :date,
    :excerpt,
    :slug,
    :tags,
    :title
  ]

  @doc """
  A helper function leveraged used by NimblePublisher to create each of our Post structs provided the filename, file's metadata, and the file body. Generates the post slug by trimming the date from filenames to match the legacy Jekyll blog post format.

  Examples

    iex> build("2021_06_15_really_smart_blog_post.md", %{}, "")
    %Post{slug: "really_smart_blog_post"}

  """
  def build(filename, attrs, body) do
    date_prefix_length = 11

    slug =
      filename
      |> Path.basename(".md")
      |> String.slice(date_prefix_length..-1)

    struct!(__MODULE__, [body: body, slug: slug] ++ Map.to_list(attrs))
  end
end
