defmodule Mix.Tasks.SchoolHouse.Gen.Sitemap do
  use Mix.Task

  @moduledoc """
  Generate a complete sitemap including all locale URLs
  """

  alias SchoolHouse.{Lessons, Posts}
  alias SchoolHouseWeb.{Endpoint, Router.Helpers}

  @destination "priv/static/sitemap.xml"
  @destination_dark_mode "priv/static/sitemap_dark_mode.xml"

  def run(_args) do
    Mix.Task.run("app.start")

    generate()
  end

  def generate do
    links =
      all_links(:light)
      |> Enum.map(&link_xml/1)
      |> Enum.join()

    dark_mode_links =
      all_links(:dark)
      |> Enum.map(&link_xml/1)
      |> Enum.join()

    write_to_priv_file!(@destination, generate_document(links))
    write_to_priv_file!(@destination_dark_mode, generate_document(dark_mode_links))
  end

  defp write_to_priv_file!(file_path, contents) do
    :school_house
    |> Application.app_dir(file_path)
    |> File.write!(contents)
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

  defp all_links(theme) do
    top_level_pages = [{:post, :index}, {:page, :privacy}]

    Enum.map(top_level_pages, &create_helper_link(&1, theme)) ++
      post_links(theme) ++ Enum.flat_map(supported_locales(), &locale_links(&1, theme))
  end

  defp locale_links(locale, theme), do: page_links(locale, theme) ++ lesson_links(locale, theme)

  defp page_links(locale, theme) do
    pages = [
      {:live, SchoolHouseWeb.ConferencesLive},
      {:page, :index},
      {:page, :podcasts},
      {:page, :why},
      {:page, :get_involved},
      {:report, :index}
    ]

    Enum.map(pages, &create_helper_link(&1, locale, theme))
  end

  defp lesson_links(locale, theme) do
    config = Application.get_env(:school_house, :lessons)

    translated_lesson_links =
      for {section, lessons} <- config, lesson <- lessons, translated_lesson?(section, lesson, locale) do
        apply_theme(theme, &Helpers.lesson_url/6, [Endpoint, :lesson, locale, section, lesson])
      end

    section_indexes =
      for section <- Keyword.keys(config) do
        apply_theme(theme, &Helpers.lesson_url/5, [Endpoint, :index, locale, section])
      end

    section_indexes ++ translated_lesson_links
  end

  defp translated_lesson?(section, lesson, locale) do
    case Lessons.get(section, lesson, locale) do
      {:ok, _} -> true
      _ -> false
    end
  end

  defp post_links(theme) do
    0..(Posts.pages() - 1)
    |> Enum.flat_map(&Posts.page/1)
    |> Enum.map(fn post ->
      apply_theme(theme, &Helpers.post_url/4, [Endpoint, :show, post.slug])
    end)
  end

  defp supported_locales do
    :school_house
    |> Application.get_env(SchoolHouseWeb.Gettext)
    |> Keyword.get(:locales)
  end

  defp create_helper_link({:page, page}, theme) do
    apply_theme(theme, &Helpers.page_url/3, [Endpoint, page])
  end

  defp create_helper_link({:post, page}, theme) do
    apply_theme(theme, &Helpers.post_url/3, [Endpoint, page])
  end

  defp create_helper_link({:page, page}, locale, theme) do
    apply_theme(theme, &Helpers.page_url/4, [Endpoint, page, locale])
  end

  defp create_helper_link({:live, page}, locale, theme) do
    apply_theme(theme, &Helpers.live_url/4, [Endpoint, page, locale])
  end

  defp create_helper_link({:report, page}, locale, theme) do
    apply_theme(theme, &Helpers.report_url/4, [Endpoint, page, locale])
  end

  defp apply_theme(:dark, routes_helper_fn, args) do
    apply(routes_helper_fn, args ++ [[ui: :dark]])
  end

  defp apply_theme(:light, routes_helper_fn, args) do
    apply(routes_helper_fn, args ++ [[]])
  end
end
