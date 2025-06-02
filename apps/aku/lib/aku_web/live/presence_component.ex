defmodule PresenceComponent do
  use Phoenix.LiveComponent

  def render(assigns) do
    ~H"""
    <span>Anslutna: <%= @present %></span>
    """
  end
end
