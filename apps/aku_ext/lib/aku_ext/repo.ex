defmodule AkuExt.Repo do
  use Ecto.Repo,
    otp_app: :aku_ext,
    adapter: Ecto.Adapters.Postgres
end
