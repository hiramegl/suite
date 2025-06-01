defmodule Aku.Repo do
  use Ecto.Repo,
    otp_app: :aku,
    adapter: Ecto.Adapters.Postgres
end
