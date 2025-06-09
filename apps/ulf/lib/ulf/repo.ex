defmodule Ulf.Repo do
  use Ecto.Repo,
    otp_app: :ulf,
    adapter: Ecto.Adapters.Postgres
end
