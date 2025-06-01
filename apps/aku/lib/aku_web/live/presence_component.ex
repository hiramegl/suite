defmodule PresenceComponent do
  use Phoenix.LiveComponent

  def render(assigns) do
    ~H"""
    <h1 class="text-center pt-2 text-xl">Anslutna klienter: <%= @present %></h1>
    """
  end
end
