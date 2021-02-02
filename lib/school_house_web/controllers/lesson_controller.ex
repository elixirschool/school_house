defmodule ElixirschoolWeb.LessonController do
  use ElixirschoolWeb, :controller

  alias SchoolHouse.Lessons

  def lesson(conn, %{"name" => name, "section" => section}) do
    case Lessons.get(section, name, Gettext.get_locale()) do
      %{} = lesson ->
        render(conn, "lesson.html", lesson: lesson)

      nil ->
        nil
        # TODO: 404 w/ translation CTA
    end
  end
end
