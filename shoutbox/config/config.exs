# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :shoutbox,
  ecto_repos: [Shoutbox.Repo]

# Configures the endpoint
config :shoutbox, ShoutboxWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "L4q1Lh3LCbYroDYQy5JfVJBEUmKgIGhJt5b+58ZeN2I1cUwZqCB2OGxIFdJl1ip6",
  render_errors: [view: ShoutboxWeb.ErrorView, accepts: ~w(html json), layout: false],
  pubsub_server: Shoutbox.PubSub,
  live_view: [signing_salt: "JE2VkCHx"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
