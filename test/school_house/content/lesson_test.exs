defmodule SchoolHouse.LessonTest do
  use ExUnit.Case

  alias SchoolHouse.{Content.Lesson, Lessons}

  test "generates properly nested lists for table of contents" do
    assert {:ok, %Lesson{table_of_contents: toc}} = Lessons.get("basics", "enum", "en")

    assert "<ul class=\"table_of_contents\"><li><a href=\"#a\">A</a><ul><li><a href=\"#aa\">AA</a><ul><li><a href=\"#aaa\">AAA</a></li></ul></li></ul></li><li><a href=\"#b\">B</a></li></ul>" ==
             toc
  end

  test "generates table of contents for accented characters in Spanish" do
    assert {:ok, %Lesson{table_of_contents: toc}} = Lessons.get("basics", "collections", "es")

    assert toc =~ "Listas"
    assert toc =~ "Concatenación de listas"
  end

  test "generates table of contents for Korean translation" do
    assert {:ok, %Lesson{table_of_contents: toc}} = Lessons.get("basics", "collections", "ko")

    assert toc =~ "리스트"
  end

  test "generates table of contents for an assorted subset of international characters" do
    assert {:ok, %Lesson{table_of_contents: toc}} = Lessons.get("basics", "basics", "en")

    assert toc =~ "áéíóúàèìòùâêîôûäëïöüñçÁÉÍÓÚÀÈÌÒÙÂÊÎÔÛÄËÏÖÜÑÇ"
  end
end
