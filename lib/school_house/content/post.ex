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

  def build(filename, attrs, body) do
    slug = Path.basename(filename, ".md")
    struct!(__MODULE__, [body: body, slug: slug] ++ Map.to_list(attrs))
  end
end
