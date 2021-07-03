defmodule Mix.Tasks.SchoolHouse.Gen.Rss do
  use Mix.Task

  @moduledoc """
  Generate an RSS feed from posts
  """

  alias SchoolHouse.Posts
  alias SchoolHouseWeb.{Endpoint, Router.Helpers}

  @destination "assets/static/feed.xml"

  def run(_args) do
    Mix.Task.run("app.start")

    items =
      0..(Posts.pages() - 1)
      |> Enum.flat_map(&Posts.page/1)
      |> Enum.map(&link_xml/1)
      |> Enum.join()

    document = """
    <?xml version="1.0" encoding="UTF-8" ?>
    <rss xmlns:atom="http://www.w3.org/2005/Atom" version="2.0">
      <channel>
        #{items}
      </channel>
    </rss>
    """

    File.write!(@destination, document)
  end

  defp link_xml(post) do
    link = Helpers.post_url(Endpoint, :show, post.slug)

    """
    <item>
      <title>#{post.title}</title>
      <description>#{post.excerpt}</description>
      <pubDate>#{Calendar.strftime(post.date, "%a, %d %B %Y 00:00:00 +0000")}</pubDate>
      <link>#{link}</link>
      <guid isPermaLink="true">#{link}</guid>
    </item>
    """
  end
end
