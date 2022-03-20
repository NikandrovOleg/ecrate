defmodule Ecrate.Repo do
  use Ecto.Repo,
    otp_app: :ecrate,
    adapter: Ecto.Adapters.Postgres
end
