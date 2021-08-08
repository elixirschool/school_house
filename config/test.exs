use Mix.Config

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :school_house, SchoolHouseWeb.Endpoint,
  http: [port: 4002],
  server: false

# Print only warnings and errors during test
config :logger, level: :warn

config :school_house, SchoolHouseWeb.Gettext, locales: ~w(en es ko)

config :school_house,
  lesson_dir: "test/support/content/lessons",
  blog_dir: "test/support/content/posts/**/*.md",
  conference_dir: "test/support/content/conferences/**/*.md"
