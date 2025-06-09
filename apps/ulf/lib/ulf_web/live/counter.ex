defmodule UlfWeb.Counter do
  use UlfWeb, :live_view
  alias Ulf.Count
  alias Phoenix.PubSub
  alias Ulf.Presence

  @topic Count.topic
  @presence_topic "presence"

  def mount(_params, _session, socket) do
    initial_present =
      if connected?(socket) do
        PubSub.subscribe(Ulf.PubSub, @topic)
        Presence.track(self(), @presence_topic, socket.id, %{})
        UlfWeb.Endpoint.subscribe(@presence_topic)
        Presence.list(@presence_topic)
        |> map_size
      else
        0
      end
    {:ok, assign(socket, val: Count.current(), present: initial_present)}
  end

  def handle_event("inc", _, socket) do
    {:noreply, assign(socket, :val, Count.incr())}
  end

  def handle_event("dec", _, socket) do
    {:noreply, assign(socket, :val, Count.decr())}
  end

  def handle_info({:count, count}, socket) do
    {:noreply, assign(socket, val: count)}
  end

  def handle_info(
    %{event: "presence_diff", payload: %{joins: joins, leaves: leaves}},
    %{assigns: %{present: present}} = socket) do
    {_, joins} = Map.pop(joins, socket.id, %{})
    new_present = present + map_size(joins) - map_size(leaves)
    {:noreply, assign(socket, :present, new_present)}
  end

  def render(assigns) do
    ~H"""
    <.live_component module={CounterComponent} id="counter" val={@val} />
    <.live_component module={PresenceComponent} id="presence" present={@present} />
    """
  end
end
