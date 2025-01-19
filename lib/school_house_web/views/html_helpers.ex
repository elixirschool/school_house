defmodule SchoolHouseWeb.HtmlHelpers do
  @moduledoc """
  A collection of helpers to assist in working with translations and lessons
  """
  use Phoenix.Component
  use PhoenixHTMLHelpers
  use Gettext, backend: SchoolHouseWeb.Gettext

  alias SchoolHouseWeb.Router.Helpers, as: Routes
  alias SchoolHouse.Lessons

  def avatar_url(github_link), do: "#{github_link}.png"

  def current_locale do
    Gettext.get_locale(SchoolHouseWeb.Gettext)
  end

  def current_page_locale_path(%{request_path: request_path}, locale) do
    request_path
    |> String.replace(~r/^\/#{current_locale()}(\/|$)/, "/#{locale}/", global: false)
    |> String.trim_trailing("/")
  end

  def friendly_version({major, minor, patch}), do: "#{major}.#{minor}.#{patch}"

  def lesson_link(
        conn,
        section,
        name,
        class \\ "block hover:bg-purple hover:dark:bg-purple text-primary dark:text-primary-dark hover:text-white hover:dark:text-light-dark",
        do: contents
      ) do
    {destination, additional_classes} =
      if Lessons.exists?(section, name, current_locale()) do
        path = Routes.lesson_path(conn, :lesson, current_locale(), section, name)

        if path == Phoenix.Controller.current_path(conn, %{}) do
          {path, "font-bold"}
        else
          {path, ""}
        end
      else
        {"#", "cursor-not-allowed"}
      end

    class =
      if Lessons.coming_soon?(name) do
        "#{class} #{additional_classes} mr-2"
      else
        "#{class} #{additional_classes}"
      end

    content_tag(
      :span,
      [
        link(contents,
          class: "#{class} #{additional_classes}",
          to: destination
        ),
        name |> Lessons.coming_soon?() |> maybe_coming_soon_badge()
      ],
      class: "flex flex-wrap"
    )
  end

  # mod -> module
  # asgn -> assigns
  def load_locale_styles(mod, asgn) do
    sanitized_locale = String.replace(current_locale(), "-", "_")
    style_func = String.to_atom("#{sanitized_locale}_locale_styles")

    if function_exported?(mod, style_func, 1) do
      apply(mod, style_func, [asgn])
    end
  end

  def maybe_coming_soon_badge(true) do
    content_tag(
      :span,
      gettext("Coming Soon"),
      class: "rounded py-px px-1 bg-purple text-xs text-white font-semibold self-center flex-shrink-0"
    )
  end

  def maybe_coming_soon_badge(_), do: []

  def supported_locales do
    :school_house
    |> Application.get_env(SchoolHouseWeb.Gettext)
    |> Keyword.get(:locales)
  end

  def translation_status_css_class(%{status: :complete}), do: "bg-green-500"
  def translation_status_css_class(%{status: status}) when status in [:major, :missing], do: "bg-yellow-500"
  def translation_status_css_class(%{status: :minor}), do: "bg-yellow-400"
  def translation_status_css_class(%{status: :patch}), do: "bg-yellow-200"
  def translation_status_css_class(_line), do: "bg-white"
end
