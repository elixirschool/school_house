defmodule SchoolHouseWeb.LessonController do
  use SchoolHouseWeb, :controller

  alias SchoolHouse.Lessons
  alias SchoolHouseWeb.FallbackController

  action_fallback FallbackController

  def lesson(conn, %{"name" => name, "section" => section}) do
    with {:ok, lesson} <- Lessons.get(section, name, Gettext.get_locale(SchoolHouseWeb.Gettext)) do
      render(conn, "lesson.html", lesson: lesson)
    end
  end
end
