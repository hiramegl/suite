defmodule Card do
  use Phoenix.LiveComponent
  import AkuWeb.CoreComponents, only: [icon: 1]

  attr :class, :string, default: "bg-base-100"
  def render(assigns) do
    ~H"""
    <div class={"rounded-xl h-80 w-full p-6 #{@class} shadow-xl mt-2 -z-9"}>
      <div class="text-xl font-semibold">
        <.icon name={"hero-#{@icon}-solid"} class="w-5 h-5 mr-1"/>
        <%= @title %>
      </div>
      <div class="divider mt-1"></div>
      <div class="text-l font-bold">
        Lorem ipsum dolor sit amet, consectetur adipiscing elit.
      </div>
      <div class="text-l pt-3">
        Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.
      </div>
      <div class="text-l pt-3">
        Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.
      </div>
    </div>
    """
  end
end
