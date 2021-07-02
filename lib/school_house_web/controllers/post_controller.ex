defmodule SchoolHouseWeb.PostController do
  use SchoolHouseWeb, :controller

  alias SchoolHouse.Posts

  @page_title "Blog"

  def index(conn, params) do
    posts =
      params
      |> current_page()
      |> Posts.page()

    render(conn, "index.html", page_title: @page_title, posts: posts, pages: Posts.pages())
  end

  def show(conn, %{"slug" => slug}) do
    post = Posts.get(slug)
    render(conn, "post.html", page_title: @page_title, post: post)
  end

  defp current_page(params) do
    value = Map.get(params, "page", "0")

    case Integer.parse(value) do
      :error -> 0
      {page, _remainder} -> page
    end
  end
end
