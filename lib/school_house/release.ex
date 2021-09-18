defmodule SchoolHouse.Release do
  @moduledoc """
    Helper module used during releases to run rss and sitemap generation tasks.
    Based on https://hexdocs.pm/phoenix/releases.html#ecto-migrations-and-custom-commands
  """

  @app :school_house

  def generate_sitemap do
    load_app()

    Mix.Tasks.SchoolHouse.Gen.Sitemap.generate()
  end

  def generate_rss do
    load_app()

    Mix.Tasks.SchoolHouse.Gen.Rss.generate()
  end

  defp load_app do
    Application.load(@app)

    Application.put_env(@app, :minimal, true)
    Application.ensure_all_started(@app)
  end
end
