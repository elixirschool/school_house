defmodule SchoolHouse.LessonsTest do
  use ExUnit.Case

  alias SchoolHouse.{Content.Lesson, Lessons}

  describe "exists?/1" do
    test "returns whether a lesson is available" do
      assert Lessons.exists?("basics", "basics", "en")
      refute Lessons.exists?("basics", "basics", "zz")
    end
  end

  describe "get/3" do
    test "returns a lesson for a given section, name, and locale" do
      assert {:ok,
              %Lesson{
                locale: "en",
                title: "Collections",
                previous: %Lesson{title: "Basics"},
                next: %Lesson{title: "Enum"}
              }} = Lessons.get("basics", "collections", "en")
    end

    test "returns {:error, :translation_not_found} for missing translation" do
      assert {:error, :translation_not_found} == Lessons.get("basics", "basics", "zz")
    end

    test "returns {:error, :not_found} for missing lessons" do
      assert {:error, :not_found} == Lessons.get("none", "existant", "lesson")
    end
  end
end
