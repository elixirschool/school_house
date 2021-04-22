defmodule SchoolHouseWeb.HtmlHelpers do
  @moduledoc """
  A collection of helpers to assist in working with translations and lessons
  """
  use Phoenix.HTML

  alias SchoolHouseWeb.Router.Helpers, as: Routes
  alias SchoolHouse.Lessons

  def avatar_url(github_link), do: "#{github_link}.png"

  def current_page_locale_path(%{request_path: request_path}, locale) do
    String.replace(request_path, current_locale(), locale, global: false)
  end

  def lesson_link(conn, section, name, class \\ "block hover:bg-brand-purple text-brand-gray hover:text-white", do: contents) do
    {destination, additional_classes} =
      if Lessons.exists?(section, name, current_locale()) do
        {Routes.lesson_path(conn, :lesson, current_locale(), section, name), ""}
      else
        {"#", "cursor-not-allowed"}
      end

    link(contents,
      class: "#{class} #{additional_classes}",
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
