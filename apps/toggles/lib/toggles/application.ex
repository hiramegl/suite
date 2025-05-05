defmodule Toggles.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      TogglesWeb.Telemetry,
      Toggles.Repo,
      {DNSCluster, query: Application.get_env(:toggles, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: Toggles.PubSub},
      # Start the Finch HTTP client for sending emails
      {Finch, name: Toggles.Finch},
      # Start a worker by calling: Toggles.Worker.start_link(arg)
      # {Toggles.Worker, arg},
      # Start to serve requests, typically the last entry
      TogglesWeb.Endpoint
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Toggles.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    TogglesWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
