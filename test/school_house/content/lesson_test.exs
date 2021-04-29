defmodule SchoolHouse.LessonTest do
  use ExUnit.Case

  alias SchoolHouse.{Content.Lesson, Lessons}

  test "generates properly nested lists for table of contents" do
    assert {:ok, %Lesson{table_of_contents: toc}} = Lessons.get("basics", "enum", "en")

    assert "<ul><li><a href=\"#a\">A</a><ul><li><a href=\"#aa\">AA</a><ul><li><a href=\"#aaa\">AAA</a></li></ul></li></ul></li><li><a href=\"#b\">B</a></li></ul>" ==
             toc
  end
end
