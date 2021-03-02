defmodule SchoolHouseWeb.PostController do
  use SchoolHouseWeb, :controller

  alias SchoolHouse.Posts

  def index(conn) do
    render(conn, "index.html", posts: Posts.recent())
  end

  def show(conn, %{"slug" => slug}) do
    case Posts.get(slug) do
      %{} = post ->
        render(conn, "post.html", post: post)

      nil ->
        nil
    end
  end
end
