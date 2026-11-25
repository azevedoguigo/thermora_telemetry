defmodule ThermoraTelemetry.Application do
  # See https://elixir.hexdocs.pm/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      ThermoraTelemetryWeb.Telemetry,
      ThermoraTelemetry.Repo,
      {DNSCluster, query: Application.get_env(:thermora_telemetry, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: ThermoraTelemetry.PubSub},
      # Start a worker by calling: ThermoraTelemetry.Worker.start_link(arg)
      # {ThermoraTelemetry.Worker, arg},
      # Start to serve requests, typically the last entry
      ThermoraTelemetryWeb.Endpoint
    ]

    # See https://elixir.hexdocs.pm/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: ThermoraTelemetry.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    ThermoraTelemetryWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
