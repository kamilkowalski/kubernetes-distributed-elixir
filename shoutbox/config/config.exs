use Mix.Config

config :shoutbox, ShoutboxWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "L4q1Lh3LCbYroDYQy5JfVJBEUmKgIGhJt5b+58ZeN2I1cUwZqCB2OGxIFdJl1ip6",
  render_errors: [view: ShoutboxWeb.ErrorView, accepts: ~w(html json), layout: false],
  pubsub_server: Shoutbox.PubSub,
  live_view: [signing_salt: "JE2VkCHx"]

config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

config :phoenix, :json_library, Jason

import_config "#{Mix.env()}.exs"
