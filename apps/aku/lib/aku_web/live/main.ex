defmodule AkuWeb.Main do
  use AkuWeb, :live_view

  alias Aku.Presence

  import AkuWeb.Live.{
    Toolbar,
    Home,
  }

  @presence_topic "presence"
  @counter_id "the_counter"

  def mount(params, _session, socket) do
    initial_present =
      if connected?(socket) do
        Presence.track(self(), @presence_topic, socket.id, %{})
        AkuWeb.Endpoint.subscribe(@presence_topic)
        Presence.list(@presence_topic)
        |> map_size
      else
        0
      end

    showSvcs = if socket |> get_connect_params == nil do
      # no socket params means GET request, use request params
      params
        |> Map.get("show-svcs", "false")
    else
      # socket params exists, read value from socket params
      socket
        |> get_connect_params
        |> Map.get("show_svcs", "false")
    end

    {
      :ok,
      socket
      |> assign(
        present: initial_present,
        counter_id: @counter_id,
        show_svcs: showSvcs == "true"
      )
    }
  end

  def handle_event("show-svcs", %{"show-svcs" => showSvcs}, socket) do
    {:noreply, assign(socket, :show_svcs, showSvcs == "true")}
  end

  def handle_info({:count, count}, socket) do
    send_update AkuWeb.Counter, id: @counter_id, count: count
    {:noreply, socket}
  end

  def handle_info(
    %{event: "presence_diff", payload: %{joins: joins, leaves: leaves}},
    %{assigns: %{present: present}} = socket) do
    {_, joins} = Map.pop(joins, socket.id, %{})
    new_present = present + map_size(joins) - map_size(leaves)
    {:noreply, assign(socket, :present, new_present)}
  end

  def main_class(false), do: "bg-base-200"
  def main_class(true),  do: "bg-red-200"

  def render(assigns) do
    ~H"""
    <.toolbar show_svcs={@show_svcs}/>

    <main
     class={"flex-1 overflow-y-auto md:pt-4 pt-4 px-6 #{@show_svcs |> main_class}"}>
      <.home
        counter_id={@counter_id}
        present={@present}/>
      <div class="h-16"></div>
    </main>
    """
  end
end
