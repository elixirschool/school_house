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
      assert %Lesson{locale: "en", title: "Basics"} = Lessons.get("basics", "basics", "en")
    end

    test "returns nil for missing lessons" do
      assert nil == Lessons.get("basics", "basics", "zz")
    end
  end
end
