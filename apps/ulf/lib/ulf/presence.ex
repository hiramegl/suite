defmodule Ulf.Presence do
  use Phoenix.Presence,
    otp_app: :ulf,
    pubsub_server: Ulf.PubSub
end
