defmodule UlfWeb.Main do
  use UlfWeb, :live_view

  import UlfWeb.Live.{
    Toolbar,
    Home,
  }

  alias Ulf.Presence

  @presence_topic "presence"
  @counter_id "the_counter"

  def mount(params, _session, socket) do
    initial_present = socket
      |> GenLib.get_present(
        Presence,
        UlfWeb.Endpoint,
        @presence_topic)
    show_svcs = socket
      |> GenLib.get_show_svcs(params)

    {
      :ok,
      socket
      |> assign(
        present: initial_present,
        counter_id: @counter_id,
        show_svcs: show_svcs
      )
    }
  end

  def handle_event("show-svcs", %{"show-svcs" => show_svcs}, socket) do
    {:noreply, assign(socket, :show_svcs, show_svcs == "true")}
  end

  def handle_info({:count, count}, socket) do
    send_update UlfWeb.Counter, id: @counter_id, count: count
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
  def main_class(true),  do: "bg-green-200"

  def init_message() do
    %{
      "title" => "ULF - Undersökning av levnadsförhållanden",
      "alert" => "Urvalet kontrolleras på fredag",
    }
    |> JSON.encode!
  end

  def render(assigns) do
    ~H"""
    <.toolbar show_svcs={@show_svcs}/>

    <div
      class={"flex-1 overflow-y-auto md:pt-4 pt-4 px-6 #{@show_svcs |> main_class}"}>
      <.home
        counter_id={@counter_id}
        present={@present}/>
      <div class="h-16"></div>
    </div>

    <portal-messenger message={init_message()}/>
    """
  end
end
