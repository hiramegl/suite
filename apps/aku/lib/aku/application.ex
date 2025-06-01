defmodule Aku.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      Aku.Count,
      AkuWeb.Telemetry,
      Aku.Repo,
      {DNSCluster, query: Application.get_env(:aku, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: Aku.PubSub},
      # Start the Finch HTTP client for sending emails
      {Finch, name: Aku.Finch},
      # Start a worker by calling: Aku.Worker.start_link(arg)
      # {Aku.Worker, arg},
      Aku.Presence,
      # Start to serve requests, typically the last entry
      AkuWeb.Endpoint
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Aku.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    AkuWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
