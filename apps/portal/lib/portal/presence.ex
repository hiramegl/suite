defmodule Portal.Presence do
  use Phoenix.Presence,
    otp_app: :portal,
    pubsub_server: Portal.PubSub
end
