defmodule Toggles.Repo do
  use Ecto.Repo,
    otp_app: :toggles,
    adapter: Ecto.Adapters.Postgres
end
