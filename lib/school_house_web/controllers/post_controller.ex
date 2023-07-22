defmodule SchoolHouseWeb.PostController do
  use SchoolHouseWeb, :controller

  alias SchoolHouse.Content.Post
  alias SchoolHouse.Posts
  alias SchoolHouseWeb.FallbackController

  action_fallback FallbackController

  @page_title "Blog"

  def index(conn, params) do
    posts =
      params
      |> current_page()
      |> Posts.page()

    render(conn, "index.html", page_title: @page_title, posts: posts, pages: Posts.pages())
  end

  def show(conn, %{"slug" => slug}) do
    with {:ok, post} <- Posts.get(slug) do
      render(conn, "post.html", page_title: format_page_title(post), post: post)
    end
  end

  def filter_by_tag(conn, %{"tag" => tag}) do
    with {:ok, posts_by_tag} <- Posts.get_by_tag(tag) do
      render(conn, "index.html",
        blog_heading: "Posts Tagged \"#{tag}\"",
        page_title: @page_title,
        posts: posts_by_tag,
        pages: Posts.pages()
      )
    end
  end

  defp current_page(params) do
    value = Map.get(params, "page", "0")

    case Integer.parse(value) do
      :error -> 0
      {page, _remainder} -> page
    end
  end

  defp format_page_title(%Post{title: title}), do: title <> " | " <> @page_title
  defp format_page_title(_), do: @page_title
end
