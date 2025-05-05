defmodule AkuExt.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      AkuExtWeb.Telemetry,
      AkuExt.Repo,
      {DNSCluster, query: Application.get_env(:aku_ext, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: AkuExt.PubSub},
      # Start the Finch HTTP client for sending emails
      {Finch, name: AkuExt.Finch},
      # Start a worker by calling: AkuExt.Worker.start_link(arg)
      # {AkuExt.Worker, arg},
      # Start to serve requests, typically the last entry
      AkuExtWeb.Endpoint
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: AkuExt.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    AkuExtWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
