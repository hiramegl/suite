defmodule Ulf.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      UlfWeb.Telemetry,
      Ulf.Repo,
      {DNSCluster, query: Application.get_env(:ulf, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: Ulf.PubSub},
      # Start the Finch HTTP client for sending emails
      {Finch, name: Ulf.Finch},
      # Start a worker by calling: Ulf.Worker.start_link(arg)
      # {Ulf.Worker, arg},
      # Start to serve requests, typically the last entry
      UlfWeb.Endpoint
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Ulf.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    UlfWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
