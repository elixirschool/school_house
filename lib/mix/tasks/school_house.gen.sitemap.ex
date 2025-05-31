defmodule Mix.Tasks.SchoolHouse.Gen.Sitemap do
  use Mix.Task

  @moduledoc """
  Generate a complete sitemap including all locale URLs
  """

  alias SchoolHouse.{Lessons, Posts}
  alias SchoolHouseWeb.Router.Helpers
  alias SchoolHouse.LocaleInfo

  @destination "priv/static/sitemap.xml"
  @destination_dark_mode "priv/static/sitemap_dark_mode.xml"

  def run([uri_string]) do
    uri_string
    |> parse_uri()
    |> generate()
  end

  def parse_uri(uri_string) do
    case URI.parse(uri_string) do
      %{host: nil} ->
        raise ArgumentError, message: "no URI with host given"

      uri ->
        uri
    end
  end

  def generate(uri) do
    links =
      :light
      |> all_links(uri)
      |> Enum.map_join(&link_xml/1)

    dark_mode_links =
      :dark
      |> all_links(uri)
      |> Enum.map_join(&link_xml/1)

    write_to_priv_file!(@destination, generate_document(links))
    write_to_priv_file!(@destination_dark_mode, generate_document(dark_mode_links))
  end

  defp write_to_priv_file!(file_path, contents) do
    full_file_path = Application.app_dir(:school_house, file_path)

    full_file_path
    |> Path.dirname()
    |> File.mkdir_p!()

    File.write!(full_file_path, contents)
  end

  defp generate_document(links) do
    """
    <?xml version="1.0" encoding="UTF-8" ?>
    <urlset xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns="http://www.sitemaps.org/schemas/sitemap/0.9" xsi:schemaLocation="http://www.sitemaps.org/schemas/sitemap/0.9 http://www.sitemaps.org/schemas/sitemap/0.9/sitemap.xsd">
    #{links}
    </urlset>
    """
  end

  defp link_xml(url), do: "<url><loc>#{url}</loc></url>"

  defp all_links(theme, uri) do
    top_level_pages = [{:post, :index}, {:page, :privacy}]

    Enum.map(top_level_pages, &create_helper_link(&1, theme, uri)) ++
      post_links(theme, uri) ++ Enum.flat_map(LocaleInfo.list(), &locale_links(&1, theme, uri))
  end

  defp locale_links(locale, theme, uri), do: page_links(locale, theme, uri) ++ lesson_links(locale, theme, uri)

  defp page_links(locale, theme, uri) do
    pages = [
      {:live, SchoolHouseWeb.ConferencesLive},
      {:page, :index},
      {:page, :podcasts},
      {:page, :why},
      {:page, :get_involved},
      {:report, :index}
    ]

    Enum.map(pages, &create_helper_link(&1, locale, theme, uri))
  end

  defp lesson_links(locale, theme, uri) do
    config = Application.get_env(:school_house, :lessons)

    translated_lesson_links =
      for {section, lessons} <- config, lesson <- lessons, translated_lesson?(section, lesson, locale) do
        apply_theme(theme, &Helpers.lesson_url/6, [uri, :lesson, locale, section, lesson])
      end

    section_indexes =
      for section <- Keyword.keys(config) do
        apply_theme(theme, &Helpers.lesson_url/5, [uri, :index, locale, section])
      end

    section_indexes ++ translated_lesson_links
  end

  defp translated_lesson?(section, lesson, locale) do
    case Lessons.get(section, lesson, locale) do
      {:ok, _} -> true
      _ -> false
    end
  end

  defp post_links(theme, uri) do
    0..(Posts.pages() - 1)
    |> Enum.flat_map(&Posts.page/1)
    |> Enum.map(fn post ->
      apply_theme(theme, &Helpers.post_url/4, [uri, :show, post.slug])
    end)
  end

  defp create_helper_link({:page, page}, theme, uri) do
    apply_theme(theme, &Helpers.page_url/3, [uri, page])
  end

  defp create_helper_link({:post, page}, theme, uri) do
    apply_theme(theme, &Helpers.post_url/3, [uri, page])
  end

  defp create_helper_link({:page, page}, locale, theme, uri) do
    apply_theme(theme, &Helpers.page_url/4, [uri, page, locale])
  end

  defp create_helper_link({:live, page}, locale, theme, uri) do
    apply_theme(theme, &Helpers.live_url/4, [uri, page, locale])
  end

  defp create_helper_link({:report, page}, locale, theme, uri) do
    apply_theme(theme, &Helpers.report_url/4, [uri, page, locale])
  end

  defp apply_theme(:dark, routes_helper_fn, args) do
    apply(routes_helper_fn, args ++ [[ui: :dark]])
  end

  defp apply_theme(:light, routes_helper_fn, args) do
    apply(routes_helper_fn, args ++ [[]])
  end
end
