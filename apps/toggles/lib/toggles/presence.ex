defmodule Toggles.Presence do
  use Phoenix.Presence,
    otp_app: :toggles,
    pubsub_server: Toggles.PubSub
end
