defmodule Shoutbox.Application do
  @moduledoc false

  use Application

  def start(_type, _args) do
    topologies = Application.get_env(:libcluster, :topologies, [])

    children = [
      {Cluster.Supervisor, [topologies, [name: Shoutbox.ClusterSupervisor]]},
      ShoutboxWeb.Telemetry,
      {Phoenix.PubSub, name: Shoutbox.PubSub},
      ShoutboxWeb.Endpoint
    ]

    opts = [strategy: :one_for_one, name: Shoutbox.Supervisor]
    Supervisor.start_link(children, opts)
  end

  def config_change(changed, _new, removed) do
    ShoutboxWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
