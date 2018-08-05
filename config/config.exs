# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :stockex,
  ecto_repos: [Stockex.Repo]

# Configures the endpoint
config :stockex, StockexWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "baBfodAaL47vctC4ruMEUaM0B2XkmuGoUUn/r70xDYymo7k3nYZX0ZcZhbcJhMdw",
  render_errors: [view: StockexWeb.ErrorView, accepts: ~w(json)],
  pubsub: [name: Stockex.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:user_id]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
