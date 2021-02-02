# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :school_house,
  ecto_repos: [SchoolHouse.Repo]

# Configures the endpoint
config :school_house, ElixirschoolWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "nkt+Wx4IwiwuGAAwhadih8PBxcacSurWEq1mWbLUEiRuA6s+Vtl075yHVnyhxWeV",
  render_errors: [view: ElixirschoolWeb.ErrorView, accepts: ~w(html json), layout: false],
  pubsub_server: SchoolHouse.PubSub,
  live_view: [signing_salt: "zU0Cq05z"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id],
  level: :debug

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

config :school_house, ElixirschoolWeb.Gettext,
  default_locale: "en",
  locales: ~w(ar bg bn de en es fr gr id it ja ko ms no pl pt ru sk ta th tr uk vi zh-hans zh-hant)

import_config "lessons.exs"
# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
