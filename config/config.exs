# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :delivery_center_api,
  ecto_repos: [DeliveryCenterApi.Repo]

# Configures the endpoint
config :delivery_center_api, DeliveryCenterApiWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "1P8ywwRHXN+UlM+Zcozjw32mWMJbP9OywSyYH2j9QX+deQPrGhwujSmFmCzZY5uI",
  render_errors: [view: DeliveryCenterApiWeb.ErrorView, accepts: ~w(json), layout: false],
  pubsub_server: DeliveryCenterApi.PubSub,
  live_view: [signing_salt: "O7hwbDLy"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
