defmodule AkuInt.Repo do
  use Ecto.Repo,
    otp_app: :aku_int,
    adapter: Ecto.Adapters.Postgres
end
