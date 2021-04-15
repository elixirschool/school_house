defmodule SchoolHouse.PostsTest do
  use ExUnit.Case

  alias SchoolHouse.{Content.Post, Posts}

  describe "get/1" do
    test "returns a specific post by slug" do
      assert %Post{title: "Title for a post"} = Posts.get("test_blog_post")
    end
  end

  describe "page/1" do
    test "returns a specific page of posts" do
      posts = Posts.page(0)

      assert is_list(posts)
      assert 1 == length(posts)
    end
  end

  describe "pages/0" do
    test "returns the total number of post pages" do
      assert 1 == Posts.pages()
    end
  end
end
