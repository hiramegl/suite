defmodule PortalWeb.Counter do
  use Phoenix.LiveComponent

  alias Portal.Count
  alias Phoenix.PubSub

  @topic Count.topic

  def mount(socket) do
    if connected?(socket) do
      PubSub.subscribe(Portal.PubSub, @topic)
    end
    {:ok, assign(socket, val: Count.current())}
  end

  def handle_event("inc", _, socket) do
    {:noreply, assign(socket, :val, Count.incr())}
  end

  def handle_event("dec", _, socket) do
    {:noreply, assign(socket, :val, Count.decr())}
  end

  # used when another process updates the count
  def update(%{count: count}, socket) do
    {:ok, socket |> assign(:val, count)}
  end

  # used during initialization
  def update(_assigns, socket) do
    {:ok, socket}
  end

  def render(assigns) do
    ~H"""
    <div>
      <span>
        Counter: <div class="badge badge-primary"><%= @val %></div>
      </span>
      <button
        type="button"
        phx-click="dec"
        phx-target={@myself}
        class="btn btn-primary btn-xs w-10">
        -
      </button>
      <button
        type="button"
        phx-click="inc"
        phx-target={@myself}
        class="btn btn-accent btn-xs w-10">
        +
      </button>
    </div>
    """
  end
end
