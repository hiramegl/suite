defmodule CounterComponent do
  use Phoenix.LiveComponent

  def render(assigns) do
    ~H"""
    <span>
      Räknare: <%= @val %>
      <button phx-click="dec" class="w-5 rounded bg-red-500 hover:bg-red-600">-</button>
      <button phx-click="inc" class="w-5 rounded bg-green-500 hover:bg-green-600">+</button>
    </span>
    """
  end
end
