defmodule CounterComponent do
  use Phoenix.LiveComponent

  def render(assigns) do
    ~H"""
    <div class="text-center">
      <h1 class="text-4xl font-bold text-center"> Contador: <%= @val %> </h1>
      <button phx-click="dec" class="text-6xl pb-2 w-20 rounded-lg bg-red-500 hover:bg-red-600">
        -
      </button>
      <button phx-click="inc" class="text-6xl pb-2 w-20 rounded-lg bg-green-500 hover:bg-green-600">
        +
      </button>
    </div>
    """
  end
end
