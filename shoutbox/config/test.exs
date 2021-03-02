use Mix.Config

config :shoutbox, ShoutboxWeb.Endpoint,
  http: [port: 4002],
  server: false

config :logger, level: :warn
