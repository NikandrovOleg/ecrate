import Config

url_host = System.fetch_env!("URL_HOST")

config :ecrate, EcrateWeb.Endpoint,
  url: [
    scheme: System.get_env("URL_SCHEME", "https"),
    host: url_host,
    port: System.get_env("URL_PORT", "443")
  ],
  static_url: [
    host: System.get_env("URL_STATIC_HOST", url_host)
  ],
  http: [port: System.get_env("PORT", "8000")],
  secret_key_base: System.fetch_env!("SECRET_KEY_BASE")

db_user = System.get_env("POSTGRES_USER")
database = System.get_env("POSTGRES_DB", db_user)

config :ecrate, Ecrate.Repo,
  url: System.get_env("DATABASE_URL"),
  username: db_user,
  password: System.get_env("POSTGRES_PASSWORD"),
  database: database,
  hostname: System.get_env("POSTGRES_HOST", "postgres"),
  port: String.to_integer(System.get_env("POSTGRES_PORT", "5432")),
  pool_size: String.to_integer(System.get_env("POSTGRES_POOL", "15")),
  show_sensitive_data_on_connection_error: true
