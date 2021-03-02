import Config

secret_key_base =
  System.get_env("SECRET_KEY_BASE") ||
    raise """
    environment variable SECRET_KEY_BASE is missing.
    You can generate one by calling: mix phx.gen.secret
    """

config :shoutbox, ShoutboxWeb.Endpoint,
  http: [
    port: String.to_integer(System.get_env("PORT") || "4000"),
    transport_options: [socket_opts: [:inet6]]
  ],
  secret_key_base: secret_key_base

config :shoutbox, ShoutboxWeb.Endpoint, server: true

namespace =
  System.get_env("NAMESPACE") ||
    raise """
    environment variable NAMESPACE is required for clustering to work
    """

config :libcluster,
  topologies: [
    default: [
      strategy: Elixir.Cluster.Strategy.Kubernetes,
      config: [
        mode: :ip,
        kubernetes_node_basename: "shoutbox",
        kubernetes_selector: "app=shoutbox",
        kubernetes_namespace: namespace,
        kubernetes_ip_lookup_mode: :pods,
        polling_interval: 10_000
      ]
    ]
  ]
