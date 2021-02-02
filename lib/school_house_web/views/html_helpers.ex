defmodule ElixirschoolWeb.HtmlHelpers do
  use Phoenix.HTML

  alias SchoolHouse.Lessons
  alias ElixirschoolWeb.Router.Helpers, as: Routes

  def lesson_link(conn, section, name, do: contents) do
    locale = Gettext.get_locale()

    {destination, additional_classes} =
      if Lessons.exists?(section, name, locale) do
        {Routes.lesson_path(conn, :lesson, locale, section, name), ""}
      else
        {"#", "cursor-not-allowed"}
      end

    link(contents,
      class: "block hover:bg-purple text-gray-300 hover:text-white #{additional_classes}",
      to: destination
    )
  end
end
