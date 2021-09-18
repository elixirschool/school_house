import Config

secret_key_base =
  System.get_env("SECRET_KEY_BASE") ||
    raise """
    environment variable SECRET_KEY_BASE is missing.
    You can generate one by calling: mix phx.gen.secret
    """
live_view_salt =
  System.get_env("LIVE_VIEW_SALT") ||
    raise """
    environment variable LIVE_VIEW_SALT is missing.
    You can generate one by calling: mix phx.gen.secret
    """
host =
  case System.get_env("HEROKU_APP_NAME") do
    nil -> "beta.elixirschool.com"
    sub -> "#{sub}.herokuapp.com"
end

config :school_house, SchoolHouseWeb.Endpoint,
  http: [
    port: String.to_integer(System.get_env("PORT") || "4000"),
    transport_options: [socket_opts: [:inet6]]
  ],
  secret_key_base: secret_key_base,
  url: [scheme: "https", host: host, port: 443],
  live_view: [signing_salt: live_view_salt],
  server: true
