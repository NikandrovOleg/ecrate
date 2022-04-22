import Config

config :ecrate, EcrateWeb.Endpoint,
  live_reload: [
    debug_errors: true,
    code_reloader: true,
    check_origin: false,
    watchers: [],
    patterns: [
      ~r"priv/static/.*(js|css|png|jpeg|jpg|gif|svg)$",
      ~r"priv/gettext/.*(po)$",
      ~r"lib/ecrate_web/(live|views)/.*(ex)$",
      ~r"lib/ecrate_web/templates/.*(eex)$"
    ]
  ]

config :hello, Ecrate.Repo, show_sensitive_data_on_connection_error: true

config :logger, :console, format: "[$level] $message\n"

config :phoenix, :stacktrace_depth, 20

config :phoenix, :plug_init_mode, :runtime
