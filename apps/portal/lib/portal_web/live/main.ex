defmodule PortalWeb.Main do
  use PortalWeb, :live_view
  alias Portal.Count
  alias Phoenix.PubSub
  alias Portal.Presence

  @topic Count.topic
  @presence_topic "presence"

  def mount(_params, _session, socket) do
    initial_present =
      if connected?(socket) do
        PubSub.subscribe(Portal.PubSub, @topic)
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
        val: Count.current(),
        present: initial_present,
        service: "aku"
      )
    }
  end

  def handle_event("inc", _params, socket) do
    {:noreply, assign(socket, :val, Count.incr())}
  end

  def handle_event("dec", _params, socket) do
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

  def get_title("dash"), do: "Min dashboard"
  def get_title("aku"),  do: "AKU - Arbetskraftsundersökning"
  def get_title("ulf"),  do: "ULF - Undersökning av levnadsförhållanden"

  def render(assigns) do
    ~H"""
      <div class="drawer lg:drawer-open">
        <input id="left-sidebar-drawer" type="checkbox" class="drawer-toggle"/>

        <div class="drawer-content flex flex-col">
          <div class="navbar sticky top-0 bg-base-100 z-10 shadow-md">
            <.live_component
              module={TitleComponent}
              id="title"
              title={get_title(@service)}/>
            <.live_component
              module={NavbarToolsComponent}
              id="navbar_tools"/>
          </div>

          <!-- Main content ******************************************************************** -->
          <%= if @service == "dash" do %>
          <.live_component
            module={DashboardComponent}
            id="dash_comp"/>
          <% else %>
          <.live_component
            module={ServiceComponent}
            id="svc_comp"
            service={@service}/>
          <% end %>
        </div>

        <div class="drawer-side z-30">
          <label
            for="left-sidebar-drawer"
            class="drawer-overlay"></label>
          <ul class="menu pt-2 w-60 bg-primary-100 min-h-full text-base-content">
            <.live_component
              module={SidebarTopComponent}
              id="sidebar_top"/>

            <.live_component
              module={ServiceItemComponent}
              id="dashboard"
              name="Dashboard"
              icon="hero-squares-2x2-solid"
              selected={if @service == "dash", do: "true", else: "false"}/>
            <.live_component
              module={ServiceItemComponent}
              id="aku"
              name="AKU"
              icon="hero-building-office-2-solid"
              selected={if @service == "aku", do: "true", else: "false"}/>
            <.live_component
              module={ServiceItemComponent}
              id="ulf"
              name="ULF"
              icon="hero-home-modern-solid"
              selected={if @service == "ulf", do: "true", else: "false"}/>

            <!-- Shared state demo ************************************************************* -->
            <li class="">
              <div>
                <button
                  phx-click="dec"
                  class="btn btn-primary btn-xs w-10">
                  -
                </button>
                <button
                  phx-click="inc"
                  phx-value-service="aku"
                  class="btn btn-accent btn-xs w-10">
                  +
                </button>
              </div>
            </li>
            <li class="">
              <span>
                Delade data:
                <div class="badge badge-secondary"><%= @val %></div>
              </span>
            </li>
            <li class="">
              <span>
                Antal anslutna:
                <span class="badge badge-accent">
                  <%= @present %>
                </span>
              </span>
            </li>
          </ul>
        </div>
      </div>
    """
  end
end
