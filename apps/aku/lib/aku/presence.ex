defmodule Aku.Presence do
  use Phoenix.Presence,
    otp_app: :aku,
    pubsub_server: Aku.PubSub
end
