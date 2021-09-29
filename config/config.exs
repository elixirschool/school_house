# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :school_house,
  lesson_dir: "content/lessons",
  blog_dir: "content/posts/**/*.md",
  podcast_dir: "content/podcasts/*.md",
  conference_dir: "content/conferences/*.md"

# Configures the endpoint
config :school_house, SchoolHouseWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "nkt+Wx4IwiwuGAAwhadih8PBxcacSurWEq1mWbLUEiRuA6s+Vtl075yHVnyhxWeV",
  render_errors: [view: SchoolHouseWeb.ErrorView, accepts: ~w(html json), layout: false],
  pubsub_server: SchoolHouse.PubSub,
  live_view: [signing_salt: "zU0Cq05z"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id],
  level: :debug

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

config :school_house, SchoolHouseWeb.Gettext,
  default_locale: "en",
  locales: ~w(ar bg bn de el en es fr id it ja ko ms no pl pt ru sk ta th tr uk vi zh-hans zh-hant)

# Configure esbuild (the version is required)
config :esbuild,
  version: "0.12.18",
  default: [
    args: ~w(js/app.js js/initialize-theme.js --bundle --target=es2016 --outdir=../priv/static/assets),
    cd: Path.expand("../assets", __DIR__),
    env: %{"NODE_PATH" => Path.expand("../deps", __DIR__)}
  ]

import_config "lessons.exs"
import_config "redirects.exs"

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
