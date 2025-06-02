defmodule PresenceComponent do
  use Phoenix.LiveComponent

  def render(assigns) do
    ~H"""
    <span>Connected: <%= @present %></span>
    """
  end
end
