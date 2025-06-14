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

  def working() do
    "#{GenUi.hello()} / #{GenLib.hello()}"
  end

  def render(assigns) do
    ~H"""
      <div class="drawer lg:drawer-open">
        <input id="left-sidebar-drawer" type="checkbox" class="drawer-toggle"/>

        <div class="drawer-content flex flex-col">
          <div class="navbar sticky top-0 bg-base-100 z-10 shadow-md">

            <!-- Main title ******************************************************************** -->
            <div class="flex-1">
              <label
                for="left-sidebar-drawer"
                class="btn btn-primary drawer-button lg:hidden">
                <.icon name="hero-bars-3-solid" class="h-6 w-6"/>
              </label>
              <h1 class="text-2xl font-semibold ml-2">ULF - Undersökning av levnadsförhållande</h1>
            </div>

            <!-- Navbar tools and profile ****************************************************** -->
            <div class="flex-none">
              <div class="badge badge-primary badge-outline">Insamlingsomgång börjar nästa vecka</div>
              <button class="btn btn-ghost btn-circle">
                <div class="indicator">
                  <.icon name="hero-bell-solid" class="h-6 w-6"/>
                  <span class="indicator-item badge badge-secondary badge-sm">15</span>
                </div>
              </button>

              <div class="ml-6">
                <div class="text-l font-semibold grid place-content-center">SCBHIGA</div>
                <div class="text-sm grid place-content-center">IT/SV/VA</div>
              </div>
              <div class="dropdown dropdown-end ml-2">
                <label tabindex="0" class="btn btn-ghost btn-circle avatar">
                  <div class="w-10 rounded-full">
                    <img src="/images/profile.jpg" alt="profile">
                  </div>
                </label>
                <ul
                  tabindex="0"
                  class="menu menu-compact dropdown-content mt-3 p-2 shadow bg-base-100 rounded-box w-52 z-100">
                  <li class="justify-between">
                    <a href="/app/settings-profile">Profile Settings
                      <span class="badge">New</span>
                    </a>
                  </li>
                  <li class="">
                    <a href="/app/settings-billing">Bill History</a>
                  </li>
                  <div class="divider mt-0 mb-0"></div>
                  <li>
                    <a>Logout</a>
                    <span>{working()}</span>
                  </li>
                </ul>
              </div>
            </div>
          </div>

          <!-- Main content ******************************************************************** -->
          <.live_component
            module={ServiceComponent}
            id="svc_comp"
            service="ulf"/>
        </div>

        <div class="drawer-side z-30">
          <label
            for="left-sidebar-drawer"
            class="drawer-overlay"></label>
          <ul class="menu pt-2 w-60 bg-primary-100 min-h-full text-base-content">
            <!-- Top title row ***************************************************************** -->
            <li class="mb-2 font-semibold text-xl">
              <a
                href="/app/welcome"
                class="bg-green-100">
                <img
                  class="mask mask-squircle w-10"
                  src="/images/scb_logo_192.jpg"
                  alt="Portal Logo"/>
                Portal
                <div class="badge badge-accent">QA</div>
              </a>
            </li>

            <!-- Services ********************************************************************** -->
            <li class="">
              <a
                class="font-normal"
                href="/dashboard"
                aria-current="page">
                <.icon
                  name="hero-squares-2x2-solid"
                  class="h-6 w-6"/>
                Dashboard
              </a>
            </li>
            <li class="">
              <a
                class="font-semibold bg-base-200"
                href="/aku"
                aria-current="page">
                <.icon
                  name="hero-building-office-2-solid"
                  class="h-6 w-6"/>
                AKU
                <span
                  class="absolute inset-y-0 left-0 w-1 rounded-tr-md rounded-br-md bg-primary"
                  aria-hidden="true"></span>
              </a>
            </li>
            <li class="">
              <a
                class="font-normal"
                href="/ulf"
                aria-current="page">
                <.icon
                  name="hero-home-modern-solid"
                  class="h-6 w-6"/>
                ULF
              </a>
            </li>

            <!-- Shared state demo ************************************************************* -->
            <li class="">
              <div>
                <button phx-click="dec" class="btn btn-primary btn-xs w-10">-</button>
                <button phx-click="inc" class="btn btn-accent btn-xs w-10">+</button>
              </div>
            </li>
            <li class="">
              <span>
                Delade data: <div class="badge badge-secondary"><%= @val %></div>
              </span>
            </li>
            <li class="">
              <span>Antal anslutna: <span class="badge badge-accent"><%= @present %></span></span>
            </li>
          </ul>
        </div>
      </div>
    """
  end
end
