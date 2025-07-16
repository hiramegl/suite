defmodule PortalWeb.Main do
  use PortalWeb, :live_view

  alias Portal.Presence

  import PortalWeb.Live.{
    SidebarTop,
    ServiceItem,
    Title,
    NavbarTools,
    Container,
    Dashboard,
    UiUtils,
  }

  @presence_topic "presence"
  @counter_id "the_counter"

  # will be read from db:
  @dash_title "Min dashboard 🎛️"
  @dash_alert "Du fick ett meddelande från Erik"

  def mount(_params, _session, socket) do
    initial_present =
      if connected?(socket) do
        Presence.track(self(), @presence_topic, socket.id, %{})
        PortalWeb.Endpoint.subscribe(@presence_topic)
        Presence.list(@presence_topic)
        |> map_size
      else
        0
      end

    {
      :ok,
      socket
      |> assign(
        present: initial_present,
        counter_id: @counter_id,
        services: ["aku", "ulf"],
        show_svcs: false,

        service: "dash",
        title: @dash_title,
        alert: @dash_alert
      )
    }
  end

  def handle_event("svc_change", params, socket) do
    new_svc = params |> Map.get("service")
    old_svc = socket.assigns.service

    socket = if new_svc != old_svc do
      if new_svc == "dash" do
        socket
        |> assign(service: new_svc)
        |> assign(title: @dash_title)
        |> assign(alert: @dash_alert)
      else
        socket
        |> assign(service: new_svc)
      end
    else
      socket
    end

    {:noreply, socket}
  end

  def handle_event("toggle_show_svcs", _params, socket) do
    {
      :noreply,
      socket
      |> assign(
        :show_svcs,
        !socket.assigns.show_svcs
      )
    }
  end

  def handle_event(
    "service-init", %{
      "id" => _id,
      "name" => _name,
      "title" => title,
      "alert" => alert,
    } = init_data,
    socket) do
    IO.puts("---> Init data: #{init_data |> inspect}")
    {
      :noreply,
      socket
      |> assign(:title, title)
      |> assign(:alert, alert)
    }
  end

  def handle_info({:count, count}, socket) do
    send_update PortalWeb.Counter, id: @counter_id, count: count
    {:noreply, socket}
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
      <div class="drawer lg:drawer-open">
        <input id="left-sidebar-drawer" type="checkbox" class="drawer-toggle"/>

        <div class="drawer-content flex flex-col">
          <div class={"navbar sticky top-0 z-10 shadow-md #{@show_svcs |> body_class}"}>
            <.title title={@title}/>
            <.navbar_tools alert={@alert}/>
          </div>

          <!-- Main content -->
          <%= if @service == "dash" do %>
          <.dashboard
            counter_id={@counter_id}
            show_svcs={@show_svcs}/>
          <% else %>
          <.container
            service={@service}
            show_svcs={@show_svcs}/>
          <% end %>
        </div>

        <div class={"drawer-side z-30 #{@show_svcs |> body_class}"}>
          <label
            for="left-sidebar-drawer"
            class="drawer-overlay"></label>
          <ul class="menu pt-2 w-60 bg-primary-100 h-full text-base-content">
            <.sidebar_top/>

            <.service_item
              id="dash"
              name="Dashboard"
              icon="hero-squares-2x2-solid"
              selected={if @service == "dash", do: "true", else: "false"}/>
            <.service_item
              id="aku"
              name="AKU"
              icon="hero-building-office-2-solid"
              selected={if @service == "aku", do: "true", else: "false"}/>
            <.service_item
              id="ulf"
              name="ULF"
              icon="hero-home-modern-solid"
              selected={if @service == "ulf", do: "true", else: "false"}/>

            <li class="">
              <span>
                Antal anslutna:
                <span class="badge badge-accent">
                  <%= @present %>
                </span>
              </span>
            </li>
            <li class="">
                <span>
                  Visa servicar
                  <div></div>
                  <input
                    type="checkbox"
                    id="show_service_toggle"
                    class="toggle"
                    phx-click="toggle_show_svcs"
                    checked={@show_svcs}/>
                </span>
            </li>
          </ul>
        </div>
      </div>
    """
  end
end
