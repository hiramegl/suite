defmodule CounterComponent do
  use Phoenix.LiveComponent

  def render(assigns) do
    ~H"""
    <span>
      Contador: <div class="badge badge-primary"><%= @val %></div>
      <button phx-click="dec" class="btn btn-primary">-</button>
      <button phx-click="inc" class="btn btn-accent">+</button>
    </span>
    """
  end
end
