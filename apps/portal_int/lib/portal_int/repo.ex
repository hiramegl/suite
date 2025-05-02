defmodule PortalInt.Repo do
  use Ecto.Repo,
    otp_app: :portal_int,
    adapter: Ecto.Adapters.Postgres
end
