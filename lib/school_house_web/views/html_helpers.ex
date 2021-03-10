defmodule SchoolHouseWeb.HtmlHelpers do
  @moduledoc """
  A collection of helpers to assist in working with translations and lessons
  """
  use Phoenix.HTML

  alias SchoolHouseWeb.Router.Helpers, as: Routes
  alias SchoolHouse.Lessons

  def avatar_url(github_link), do: "#{github_link}.png"

  def current_page_locale_link(conn, locale) do
    current_url = Phoenix.Controller.current_url(conn)
    String.replace(current_url, current_locale(), locale)
  end

  def lesson_link(conn, section, name, do: contents) do
    {destination, additional_classes} =
      if Lessons.exists?(section, name, current_locale()) do
        {Routes.lesson_path(conn, :lesson, current_locale(), section, name), ""}
      else
        {"#", "cursor-not-allowed"}
      end

    link(contents,
      class: "block hover:bg-brand-purple text-brand-gray hover:text-white #{additional_classes}",
      to: destination
    )
  end

  def current_locale do
    Gettext.get_locale(SchoolHouseWeb.Gettext)
  end

  def supported_locales do
    :school_house
    |> Application.get_env(SchoolHouseWeb.Gettext)
    |> Keyword.get(:locales)
  end
end
