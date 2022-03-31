import Config

config :ecrate, EcrateWeb.Endpoint,
  server: true

# Do not print debug messages in production
config :logger, level: :info
