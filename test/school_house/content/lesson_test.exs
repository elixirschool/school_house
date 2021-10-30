defmodule SchoolHouse.LessonTest do
  use ExUnit.Case

  alias SchoolHouse.{Content.Lesson, Lessons}

  test "generates properly nested lists for table of contents" do
    assert {:ok, %Lesson{table_of_contents: toc}} = Lessons.get("basics", "enum", "en")

    assert "<ul class=\"table_of_contents\"><li><a href=\"#a-0\">A</a><ul><li><a href=\"#aa-1\">AA</a><ul><li><a href=\"#aaa-2\">AAA</a></li></ul></li></ul></li><li><a href=\"#b-3\">B</a><ul><li><a href=\"#aa-4\">AA</a></li></ul></li></ul>" ==
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

  test "correctly parses body" do
    assert {:ok, %Lesson{body: body}} = Lessons.get("basics", "enum", "en")

    assert body ==
             "<h2 class=\"flex\" id=\"a-0\">\n  <a href=\"#a-0\">\nA</a>\n  <a href=\"#\" title=\"go to top of page\" class=\"pt-1 ml-2\">\n    <svg xmlns=\"http://www.w3.org/2000/svg\" class=\"w-6 h-6\" fill=\"none\" viewBox=\"0 0 24 24\" stroke=\"currentColor\">\n      <path stroke-linecap=\"round\" stroke-linejoin=\"round\" stroke-width=\"2\" d=\"M5 15l7-7 7 7\"></path>\n    </svg>\n  </a>\n</h2>\n<h3 class=\"flex\" id=\"aa-1\">\n  <a href=\"#aa-1\">\nAA</a>\n  <a href=\"#\" title=\"go to top of page\" class=\"pt-1 ml-2\">\n    <svg xmlns=\"http://www.w3.org/2000/svg\" class=\"w-6 h-6\" fill=\"none\" viewBox=\"0 0 24 24\" stroke=\"currentColor\">\n      <path stroke-linecap=\"round\" stroke-linejoin=\"round\" stroke-width=\"2\" d=\"M5 15l7-7 7 7\"></path>\n    </svg>\n  </a>\n</h3>\n<h4 class=\"flex\" id=\"aaa-2\">\n  <a href=\"#aaa-2\">\nAAA</a>\n  <a href=\"#\" title=\"go to top of page\" class=\"pt-1 ml-2\">\n    <svg xmlns=\"http://www.w3.org/2000/svg\" class=\"w-6 h-6\" fill=\"none\" viewBox=\"0 0 24 24\" stroke=\"currentColor\">\n      <path stroke-linecap=\"round\" stroke-linejoin=\"round\" stroke-width=\"2\" d=\"M5 15l7-7 7 7\"></path>\n    </svg>\n  </a>\n</h4>\n<h2 class=\"flex\" id=\"b-3\">\n  <a href=\"#b-3\">\nB</a>\n  <a href=\"#\" title=\"go to top of page\" class=\"pt-1 ml-2\">\n    <svg xmlns=\"http://www.w3.org/2000/svg\" class=\"w-6 h-6\" fill=\"none\" viewBox=\"0 0 24 24\" stroke=\"currentColor\">\n      <path stroke-linecap=\"round\" stroke-linejoin=\"round\" stroke-width=\"2\" d=\"M5 15l7-7 7 7\"></path>\n    </svg>\n  </a>\n</h2>\n<h3 class=\"flex\" id=\"aa-4\">\n  <a href=\"#aa-4\">\nAA</a>\n  <a href=\"#\" title=\"go to top of page\" class=\"pt-1 ml-2\">\n    <svg xmlns=\"http://www.w3.org/2000/svg\" class=\"w-6 h-6\" fill=\"none\" viewBox=\"0 0 24 24\" stroke=\"currentColor\">\n      <path stroke-linecap=\"round\" stroke-linejoin=\"round\" stroke-width=\"2\" d=\"M5 15l7-7 7 7\"></path>\n    </svg>\n  </a>\n</h3>\n"
  end
end
