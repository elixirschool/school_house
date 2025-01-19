defmodule Mix.Tasks.SchoolHouse.Gen.Rss do
  use Mix.Task

  @moduledoc """
  Generate an RSS feed from posts
  """

  alias SchoolHouse.Posts
  alias SchoolHouseWeb.Router.Helpers

  @destination "priv/static/feed.xml"

  def run([uri_string]) do
    uri_string
    |> parse_uri()
    |> generate()
  end

  def parse_uri(uri_string) do
    case URI.parse(uri_string) do
      %{host: nil} ->
        raise ArgumentError, message: "no URI with host given"

      uri ->
        uri
    end
  end

  def generate(uri) do
    items =
      case Posts.pages() do
        0 -> ""  # Return empty string if no pages
        pages ->
          0..(pages - 1)
          |> Enum.flat_map(fn page -> Posts.page(page) || [] end)
          |> Enum.map_join(&link_xml(&1, uri))
      end

    document = """
    <?xml version="1.0" encoding="UTF-8" ?>
    <rss xmlns:atom="http://www.w3.org/2005/Atom" version="2.0">
      <channel>
        #{items}
      </channel>
    </rss>
    """

    write_to_priv_file!(@destination, document)
  end

  defp write_to_priv_file!(file_path, contents) do
    full_file_path = Application.app_dir(:school_house, file_path)

    full_file_path
    |> Path.dirname()
    |> File.mkdir_p!()

    File.write!(full_file_path, contents)
  end

  defp link_xml(post, uri) do
    link = Helpers.post_url(uri, :show, post.slug)

    """
    <item>
      <title>#{post.title_text}</title>
      <description>#{post.excerpt}</description>
      <pubDate>#{Calendar.strftime(post.date, "%a, %d %B %Y 00:00:00 +0000")}</pubDate>
      <link>#{link}</link>
      <guid isPermaLink="true">#{link}</guid>
    </item>
    """
  end
end
