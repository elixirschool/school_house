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

  test "generates nil as the previous link for first lesson" do
    assert {:ok, %Lesson{previous: previous}} = Lessons.get("basics", "basics", "en")

    assert is_nil(previous)
  end

  test "generates previous lesson for first lesson in section" do
    assert {:ok, %Lesson{previous: previous}} = Lessons.get("intermediate", "erlang", "en")

    assert previous.section == :basics
    assert previous.name == :enum
  end

  test "generates next lesson for last lesson in section" do
    assert {:ok, %Lesson{next: next}} = Lessons.get("basics", "enum", "en")

    assert next.section == :intermediate
    assert next.name == :erlang
  end

  test "generates nil as the next lesson for last lesson" do
    assert {:ok, %Lesson{next: next}} = Lessons.get("intermediate", "erlang", "en")

    assert is_nil(next)
  end
end
