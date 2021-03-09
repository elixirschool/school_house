defmodule SchoolHouseWeb.PostController do
  use SchoolHouseWeb, :controller

  alias SchoolHouse.Posts

  def index(conn, params) do
    posts =
      params
      |> current_page()
      |> Posts.page()

    render(conn, "index.html", posts: posts)
  end

  def show(conn, %{"slug" => slug}) do
    case Posts.get(slug) do
      %{} = post ->
        render(conn, "post.html", post: post)

      nil ->
        nil
    end
  end

  defp current_page(params) do
    value = Map.get(params, "page", "0")

    case Integer.parse(value) do
      :error -> 0
      {page, _remainder} -> page
    end
  end
end
