# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :car_data,
  ecto_repos: [CarData.Repo]

# Configures the endpoint
config :car_data, CarDataWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "JGab9jph8+JSyei7u4EaLg9rl8KJ3ITSRhFIN71nr7VBQqJNEKAqaTLhGFfdO4N/",
  render_errors: [view: CarDataWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: CarData.PubSub, adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
