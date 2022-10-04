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
                next: %Lesson{title: "Enum"},
                version: {1, 3, 1}
              }} = Lessons.get("basics", "collections", "en")
    end

    test "returns {:error, :translation_not_found, missing_locale} for missing translation" do
      assert {:error, :translation_not_found, "es"} == Lessons.get("basics", "enum", "es")
    end

    test "returns {:error, :not_found} for missing lessons" do
      assert {:error, :not_found} == Lessons.get("none", "existent", "lesson")
    end
  end

  describe "locale_report/1" do
    test "returns a report of translated content for a locale" do
      %{basics: basics_report} = Lessons.translation_report("es")
      assert %{status: :complete} = Enum.find(basics_report, &(&1.name == :basics))
      assert %{status: :missing} = Enum.find(basics_report, &(&1.name == :enum))
      assert %{original: nil} = Enum.find(basics_report, &(&1.name == :functions))
    end
  end
end
