defmodule PortalExt.Repo do
  use Ecto.Repo,
    otp_app: :portal_ext,
    adapter: Ecto.Adapters.Postgres
end
