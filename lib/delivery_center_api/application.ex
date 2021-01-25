defmodule DeliveryCenterApi.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  def start(_type, _args) do
    children = [
      # Start the Ecto repository
      DeliveryCenterApi.Repo,
      # Start the Telemetry supervisor
      DeliveryCenterApiWeb.Telemetry,
      # Start the PubSub system
      {Phoenix.PubSub, name: DeliveryCenterApi.PubSub},
      # Start the Endpoint (http/https)
      DeliveryCenterApiWeb.Endpoint
      # Start a worker by calling: DeliveryCenterApi.Worker.start_link(arg)
      # {DeliveryCenterApi.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: DeliveryCenterApi.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  def config_change(changed, _new, removed) do
    DeliveryCenterApiWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
