defmodule SchoolHouseWeb.HtmlHelpers do
  @moduledoc """
  A collection of helpers to assist in working with translations and lessons
  """
  use Phoenix.HTML

  alias SchoolHouseWeb.Router.Helpers, as: Routes
  alias SchoolHouse.Lessons

  def avatar_url(github_link), do: "#{github_link}.png"

  def current_locale do
    Gettext.get_locale(SchoolHouseWeb.Gettext)
  end

  def current_page_locale_path(%{request_path: request_path}, locale) do
    String.replace(request_path, current_locale(), locale, global: false)
  end

  def friendly_version({major, minor, patch}), do: "#{major}.#{minor}.#{patch}"

  def lesson_link(conn, section, name, class \\ "block hover:bg-brand-purple-800 hover:dark:bg-brand-purple-200 text-brand-gray-750 dark:text-gray-200 hover:text-white hover:dark:text-brand-gray",
        do: contents
      ) do
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

  def supported_locales do
    :school_house
    |> Application.get_env(SchoolHouseWeb.Gettext)
    |> Keyword.get(:locales)
  end

  def translation_status_css_class(%{status: :complete}), do: "bg-green-500"
  def translation_status_css_class(%{status: status}) when status in [:major, :missing], do: "bg-red-500"
  def translation_status_css_class(%{status: :minor}), do: "bg-yellow-500"
  def translation_status_css_class(%{status: :patch}), do: "bg-yellow-200"
  def translation_status_css_class(_line), do: "bg-white"
end
