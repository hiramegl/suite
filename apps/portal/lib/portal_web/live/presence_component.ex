defmodule PresenceComponent do
  use Phoenix.LiveComponent

  def render(assigns) do
    ~H"""
    <span>Connected: <span class="badge badge-accent"><%= @present %></span></span>
    """
  end
end
