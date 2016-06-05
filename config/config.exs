# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"

secret_key_base = "5mj0E6l33xATZTVznKQGSqwbVo9SSqvdsDi/3UmCJJU3FDX85cOqTj2O64d/FYjG"

# Configures the endpoint
config :telmak, Telmak.Endpoint,
  url: [host: "localhost"],
  root: Path.dirname(__DIR__),
  secret_key_base: secret_key_base,
  render_errors: [accepts: ~w(json)],
  pubsub: [name: Telmak.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Configure phoenix generators
config :phoenix, :generators,
  migration: true,
  binary_id: false

config :phoenix, :format_encoders, "json-api": Poison
config :plug, :mimes, %{"application/vnd.api+json" => ["json-api"]}

config :guardian, Guardian,
  secret_key: secret_key_base,
  issuer: "Telmak",
  ttl: { 30, :days },
  serializer: Telmak.GuardianSerializer

config :ueberauth, Ueberauth,
  providers: [
    google: {Ueberauth.Strategy.Google, [
      callback_methods: ["POST"],
      callback_path: "/api/auth/google/callback",
      callback_url: "http://localhost:3333"
    ]}
  ]
