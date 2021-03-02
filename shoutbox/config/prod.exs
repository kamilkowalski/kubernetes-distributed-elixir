use Mix.Config

config :shoutbox, ShoutboxWeb.Endpoint,
  url: [host: "localhost", port: 80],
  cache_static_manifest: "priv/static/cache_manifest.json"

config :logger, level: :debug
