defmodule SchoolHouse.MixProject do
  use Mix.Project

  def project do
    [
      app: :school_house,
      version: "0.1.0",
      elixir: "~> 1.17",
      elixirc_paths: elixirc_paths(Mix.env()),
      compilers: Mix.compilers(),
      start_permanent: Mix.env() == :prod,
      aliases: aliases(),
      deps: deps(),
      dialyzer: [
        plt_add_apps: [:mix]
      ],
      releases: releases()
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

  def releases do
    [
      school_house: [
        include_executables_for: [:unix],
        cookie: "school_house"
      ]
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
      {:appsignal, "~> 2.8"},
      {:appsignal_phoenix, "~> 2.3"},
      {:gettext, "~> 0.24"},
      {:jason, "~> 1.4"},
      {:libcluster, "~> 3.4"},
      {:locale_plug, "~> 0.1.0"},
      {:makeup_elixir, "~> 0.16.1"},
      {:makeup_erlang, "~> 0.1.3"},
      {:nimble_publisher, "~> 1.1"},
      {:phoenix, "~> 1.7.11"},
      {:phoenix_html, "~> 4.0"},
      {:phoenix_html_helpers, "~> 1.0"},
      {:phoenix_live_view, "~> 0.20.2"},
      {:plug_cowboy, "~> 2.7"},
      {:ssl_verify_fun, "~> 1.1.7", manager: :rebar3, override: true},
      {:telemetry_metrics, "~> 0.6"},
      {:telemetry_poller, "~> 1.0"},

      # Dev & Test dependencies
      {:credo, "~> 1.6", only: [:dev, :test]},
      {:dialyxir, "~> 1.0", only: [:dev, :test], runtime: false},
      {:esbuild, "~> 0.2", runtime: Mix.env() == :dev},
      {:floki, ">= 0.0.0", only: :test},
      {:phoenix_live_reload, "~> 1.2", only: :dev},
      {:phoenix_view, "~> 2.0"}
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
        "cmd cp -r assets/static priv",
        "phx.digest"
      ]
    ]
  end
end
