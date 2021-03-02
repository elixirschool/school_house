defmodule SchoolHouseWeb.LessonController do
  use SchoolHouseWeb, :controller

  alias SchoolHouse.Lessons

  def lesson(conn, %{"name" => name, "section" => section}) do
    case Lessons.get(section, name, Gettext.get_locale()) do
      %{} = lesson ->
        render(conn, "lesson.html", lesson: lesson)

      nil ->
        render(conn, "404.html")
    end
  end
end
