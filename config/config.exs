# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :shopping_app,
  ecto_repos: [ShoppingApp.Repo]

# Configures the endpoint
config :shopping_app, ShoppingAppWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "HqmHVv8T4MreQJMIIlvg5CuPQyoHBDmFuFIUIFbyReu67do37SCVyvtE4u7HYgCR",
  render_errors: [view: ShoppingAppWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: ShoppingApp.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:user_id]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
