defmodule SchoolHouseWeb.HtmlHelpers do
  @moduledoc """
  A collection of helpers to assist in working with translations and lessons
  """
  use Phoenix.HTML

  alias SchoolHouseWeb.Router.Helpers, as: Routes
  alias SchoolHouse.Lessons

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
