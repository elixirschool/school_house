defmodule Mix.Tasks.SchoolHouse.Gen.Sitemap do
  use Mix.Task

  @moduledoc """
  Generate a complete sitemap including all locale URLs
  """

  alias SchoolHouse.{Lessons, Posts}
  alias SchoolHouseWeb.{Endpoint, Router.Helpers}

  @destination "assets/static/sitemap.xml"

  def run(_args) do
    Mix.Task.run("app.start")

    links =
      all_links()
      |> Enum.map(&link_xml/1)
      |> Enum.join()

    document = """
    <?xml version="1.0" encoding="UTF-8" ?>
    <urlset xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns="http://www.sitemaps.org/schemas/sitemap/0.9" xsi:schemaLocation="http://www.sitemaps.org/schemas/sitemap/0.9 http://www.sitemaps.org/schemas/sitemap/0.9/sitemap.xsd">
    #{links}
    </urlset>
    """

    File.write!(@destination, document)
  end

  defp link_xml(url), do: "<url><loc>#{url}</loc></url>"

  defp all_links do
    [
      Helpers.post_url(Endpoint, :index),
      Helpers.page_url(Endpoint, :privacy)
    ] ++ post_links() ++ Enum.flat_map(supported_locales(), &locale_links/1)
  end

  defp locale_links(locale), do: page_links(locale) ++ lesson_links(locale)

  defp page_links(locale) do
    [
      Helpers.live_url(Endpoint, SchoolHouseWeb.ConferencesLive, locale),
      Helpers.page_url(Endpoint, :index, locale),
      Helpers.page_url(Endpoint, :podcasts, locale),
      Helpers.page_url(Endpoint, :why, locale),
      Helpers.report_url(Endpoint, :index, locale)
    ]
  end

  defp lesson_links(locale) do
    config = Application.get_env(:school_house, :lessons)

    translated_lesson_links =
      for {section, lessons} <- config, lesson <- lessons, translated_lesson?(section, lesson, locale) do
        Helpers.lesson_url(Endpoint, :lesson, section, lesson, locale)
      end

    section_indexes =
      for section <- Keyword.keys(config) do
        Helpers.lesson_url(Endpoint, :index, section, locale)
      end

    section_indexes ++ translated_lesson_links
  end

  defp translated_lesson?(section, lesson, locale) do
    case Lessons.get(section, lesson, locale) do
      {:ok, _} -> true
      _ -> false
    end
  end

  defp post_links do
    0..(Posts.pages() - 1)
    |> Enum.flat_map(&Posts.page/1)
    |> Enum.map(&Helpers.post_url(Endpoint, :show, &1.slug))
  end

  defp supported_locales do
    :school_house
    |> Application.get_env(SchoolHouseWeb.Gettext)
    |> Keyword.get(:locales)
  end
end
