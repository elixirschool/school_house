defmodule SchoolHouse.PostsTest do
  use ExUnit.Case

  alias SchoolHouse.{Content.Post, Posts}

  describe "get/1" do
    test "returns a specific post by slug" do
      assert {:ok, %Post{title: "<p>\nTitle for a post</p>\n"}} = Posts.get("test_blog_post")
    end

    test "returns error if post not found" do
      assert {:error, :not_found} == Posts.get("unknown")
    end
  end

  describe "get_by_tag/1" do
    test "returns the correct number of posts by tag" do
      {:ok, posts} = Posts.get_by_tag("general")

      assert is_list(posts)
      assert 2 == length(posts)
    end

    test "returns error if no posts found" do
      assert {:error, :not_found} == Posts.get_by_tag("unknown")
    end
  end

  describe "page/1" do
    test "returns a specific page of posts" do
      posts = Posts.page(0)

      assert is_list(posts)
      assert 2 == length(posts)
    end
  end

  describe "pages/0" do
    test "returns the total number of post pages" do
      assert 1 == Posts.pages()
    end
  end
end
