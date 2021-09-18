defmodule SchoolHouse.Release do
  @app :school_house

  def generate_sitemap do
    load_app()

    Mix.Tasks.SchoolHouse.Gen.Sitemap.generate()
  end

  defp load_app do
    Application.load(@app)

    Application.put_env(@app, :minimal, true)
    Application.ensure_all_started(@app)
  end
end
