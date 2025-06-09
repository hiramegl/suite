defmodule UlfWeb.Main do
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
    <div class="navbar sticky top-0">
      <div class="flex-1">
        <button class="btn btn-primary text-xl">
          <.icon name="hero-home-solid" class="w-5 h-5"/>
          Hem
        </button>
        <div class="dropdown ml-1">
          <div tabindex="0" role="button" class="btn m-1 text-xl">
            <.icon name="hero-calendar-solid" class="w-5 h-5"/>
            2025-Q1
          </div>
          <ul
            tabindex="0"
            class="dropdown-content menu bg-base-100 rounded-box z-200 w-52 p-2 shadow">
            <li><a>2026</a></li>
            <li>
              <details open>
                <summary>2025</summary>
                <ul>
                  <li>
                    <details open>
                      <summary>Q1</summary>
                      <ul>
                        <li><a>Jan</a></li>
                        <li><a>Feb</a></li>
                        <li><a>Mar</a></li>
                      </ul>
                    </details>
                  </li>
                  <li><a>Q2</a></li>
                  <li><a>Q3</a></li>
                </ul>
              </details>
            </li>
            <li><a>2024</a></li>
            <li><a>2023</a></li>
            <li>
              <a>
                <.icon name="hero-archive-box-solid" class="w-5 h-5"/>
                Arkiv
              </a>
            </li>
          </ul>
        </div>
        <button class="btn text-xl ml-2">
          <.icon name="hero-calendar-days-solid" class="w-5 h-5"/>
          Planering
        </button>
        <button class="btn text-xl ml-2">
          <.icon name="hero-inbox-arrow-down-solid" class="w-5 h-5"/>
          Insamling
        </button>
        <button class="btn text-xl ml-2">
          <.icon name="hero-square-3-stack-3d-solid" class="w-5 h-5"/>
          Bearbetning
        </button>
        <button class="btn text-xl ml-2">
          <.icon name="hero-presentation-chart-bar-solid" class="w-5 h-5"/>
          Analys
        </button>
        <button class="btn text-xl ml-2">
          <.icon name="hero-newspaper-solid" class="w-5 h-5"/>
          Rapportering
        </button>
        <button class="btn text-xl ml-2">
          <.icon name="hero-scale-solid" class="w-5 h-5"/>
          Utvärdering
        </button>
      </div>

      <div class="flex-none">
        <button class="btn text-xl">
          <.icon name="hero-wrench-screwdriver-solid" class="w-5 h-5"/>
        </button>
        <button class="btn text-xl ml-2">
          <.icon name="hero-chat-bubble-left-right-solid" class="w-5 h-5"/>
        </button>
        <button class="btn dropdown dropdown-end ml-2">
          <.icon
            name="hero-bars-4-solid"
            class="w-5"/>
          <ul
            tabindex="0"
            class="dropdown-content menu menu-compact p-2 shadow bg-base-100 rounded-box w-52 z-20">
            <li>
              <a>
                <.icon name="hero-question-mark-circle-solid" class="w-5"/>
                Hjälp
              </a>
            </li>
            <li>
              <a>
                <.icon name="hero-envelope-solid" class="w-5"/>
                Meddelande
              </a>
            </li>
            <li>
              <a>
                <.icon name="hero-exclamation-triangle-solid" class="w-5"/>
                Skapa ett ärende
              </a>
            </li>
            <li>
              <a>
                <.icon name="hero-cog-6-tooth-solid" class="w-5"/>
                Inställningar
              </a>
            </li>
          </ul>
        </button>
      </div>
    </div>

    <main class="flex-1 overflow-y-auto md:pt-4 pt-4 px-6 bg-base-200">
      <div class="grid lg:grid-cols-4 grid-cols-1 gap-6">
        <.live_component
          module={Card}
          id="card_1_1"
          icon="square-3-stack-3d"
          title="Bearbetning 2025-Q1"/>
        <.live_component
          module={Card}
          id="card_1_2"
          icon="calendar-days"
          title="Planering 2025-Q4"/>
        <.live_component
          module={Card}
          id="card_1_3"
          icon="square-3-stack-3d"
          title="Bearbetning 2024-Q3"/>
        <div class="bg-white rounded-xl h-80 w-full p-6 shadow-xl mt-2 -z-9">
          <div class="text-xl font-semibold">
            <.icon name="hero-presentation-chart-bar-solid" class="w-5 h-5 mr-1"/>
            Analys 2024-Q4
          </div>
          <div class="divider mt-1"></div>
          <img
            src="/ulf/images/chart01.jpg"
            class="h-52 ml-12"/>
        </div>
      </div>

      <div class="grid lg:grid-cols-4 grid-cols-1 gap-6">
        <div class="bg-white rounded-xl h-80 w-full p-6 shadow-xl mt-2 -z-9">
          <div class="text-xl font-semibold">
            <.icon name="hero-circle-stack-solid" class="w-5 h-5 mr-1"/>
            Delade data
          </div>
          <div class="divider mt-1"></div>
          <div class="mb-2">
            <button phx-click="dec" class="btn btn-primary btn-xs w-10">-</button>
            <button phx-click="inc" class="btn btn-accent btn-xs w-10">+</button>
          </div>
          <div>
            Räknare: <div class="badge badge-secondary"><%= @val %></div>
          </div>
          <div>
            Antal anslutna: <span class="badge badge-accent"><%= @present %></span>
          </div>
        </div>
        <.live_component
          module={Card}
          id="card_2_2"
          icon="square-3-stack-3d"
          title="Bearbetning 2024-Q4"/>
        <.live_component
          module={Card}
          id="card_2_3"
          icon="presentation-chart-bar"
          title="Analys 2025-Q1"/>
        <.live_component
          module={Card}
          class="bg-red-50"
          id="card_2_4"
          icon="envelope"
          title="Viktiga meddelande"/>
      </div>

      <div class="grid lg:grid-cols-4 grid-cols-1 gap-6">
        <.live_component
          module={Card}
          class="bg-teal-50"
          id="card_3_1"
          icon="chat-bubble-left-right"
          title="Konversation med Sven"/>
        <.live_component
          module={Card}
          id="card_3_2"
          icon="square-3-stack-3d"
          title="Bearbetning 2024-Q1"/>
        <.live_component
          module={Card}
          id="card_3_3"
          icon="presentation-chart-bar"
          title="Analys 2024-Q3"/>
      </div>

      <div class="h-16"></div>
    </main>
    """
  end
end
