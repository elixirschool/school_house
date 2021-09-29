defmodule SchoolHouse.MixProject do
  use Mix.Project

  def project do
    [
      app: :school_house,
      version: "0.1.0",
      elixir: "~> 1.12",
      elixirc_paths: elixirc_paths(Mix.env()),
      compilers: [:phoenix, :gettext] ++ Mix.compilers(),
      start_permanent: Mix.env() == :prod,
      aliases: aliases(),
      deps: deps(),
      dialyzer: [
        plt_add_apps: [:mix]
      ]
    ]
  end

  # Configuration for the OTP application.
  #
  # Type `mix help compile.app` for more information.
  def application do
    [
      mod: {SchoolHouse.Application, []},
      extra_applications: [:logger, :runtime_tools]
    ]
  end

  # Specifies which paths to compile per environment.
  defp elixirc_paths(:test), do: ["lib", "test/support"]
  defp elixirc_paths(_), do: ["lib"]

  # Specifies your project dependencies.
  #
  # Type `mix help deps` for examples and options.
  defp deps do
    [
      {:appsignal, "~> 2.2"},
      {:appsignal_phoenix, "~> 2.0.12"},
      {:gettext, "~> 0.11"},
      {:jason, "~> 1.0"},
      {:locale_plug, "~> 0.1.0"},
      {:makeup_elixir, ">= 0.0.0"},
      {:makeup_erlang, ">= 0.0.0"},
      {:nimble_publisher, "~> 0.1"},
      {:phoenix, "~> 1.6.0"},
      {:phoenix_html, "~> 3.0"},
      {:phoenix_live_view, "~> 0.16"},
      {:plug_cowboy, "~> 2.0"},
      {:esbuild, "~> 0.2", runtime: Mix.env() == :dev},
      {:telemetry_metrics, "~> 0.6"},
      {:telemetry_poller, "~> 0.5"},

      # Dev & Test dependencies
      {:credo, ">= 0.0.0", only: :dev},
      {:dialyxir, "~> 1.0", only: [:dev, :test], runtime: false},
      {:floki, ">= 0.0.0", only: :test},
      {:phoenix_live_reload, "~> 1.2", only: :dev}
    ]
  end

  # Aliases are shortcuts or tasks specific to the current project.
  # For example, to install project dependencies and perform other setup tasks, run:
  #
  #     $ mix setup
  #
  # See the documentation for `Mix` for more info on aliases.
  defp aliases do
    [
      setup: ["deps.get", "cmd --cd assets npm install"],
      "assets.deploy": [
        "cmd --cd assets npm run deploy",
        "esbuild default --minify",
        "phx.digest"
      ]
    ]
  end
end
