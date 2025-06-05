defmodule PresenceComponent do
  use Phoenix.LiveComponent

  def render(assigns) do
    ~H"""
    <span>Anslutna: <span class="badge badge-accent"><%= @present %></span></span>
    """
  end
end
