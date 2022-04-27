# This file is responsible for configuring your application
# and its dependencies with the aid of the Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
import Config

config :ecrate,
  ecto_repos: [Ecrate.Repo]

config :ecrate, EcrateWeb.Endpoint,
  http: [ip: {0, 0, 0, 0, 0, 0, 0, 0}],
  render_errors: [
    view: EcrateWeb.ErrorView,
    accepts: ~w(html json),
    layout: false
  ],
  pubsub_server: Ecrate.PubSub,
  live_view: [signing_salt: "YoxDy1DF"]

config :hello, Ecrate.Repo, adapter: Ecto.Adapters.Postgres

config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

config :phoenix, :json_library, Jason

config :ecrate, Ecrate.Mailer, adapter: Swoosh.Adapters.Local

config :swoosh, :api_client, false

config :esbuild,
  version: "0.14.0",
  default: [
    args:
      ~w(js/app.js --bundle --target=es2017 --outdir=../priv/static/assets --external:/fonts/* --external:/images/*),
    cd: Path.expand("../assets", __DIR__),
    env: %{"NODE_PATH" => Path.expand("../deps", __DIR__)}
  ]

import_config "#{Mix.env()}.exs"
