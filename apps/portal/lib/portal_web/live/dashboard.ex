defmodule PortalWeb.Live.Dashboard do
  use Phoenix.Component

  import GenUi.Card
  import GenUi.Icon
  import GenUi.Button

  import PortalWeb.Live.UiUtils

  attr :counter_id, :string, required: true
  attr :show_svcs,  :boolean, required: true

  def dashboard(assigns) do
    ~H"""
    <div>
      <div class={"navbar sticky top-0 #{@show_svcs |> body_class}"}>
        <div class="flex-1">
          <.button
            icon="hero-home-solid"
            text="Hem"
            selected={true}/>
          <.button
            icon="hero-calendar-days-solid"
            text="Intervju schema"/>
          <.button
            icon="hero-rocket-launch-solid"
            text="Semester"/>
          <.button
            icon="hero-presentation-chart-bar-solid"
            text="Statistik"/>
          <.button
            icon="hero-newspaper-solid"
            text="Rapporter"/>
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

      <main class={"flex-1 overflow-y-auto md:pt-4 pt-4 px-6 #{@show_svcs |> main_class}"}>
        <div class="grid lg:grid-cols-4 grid-cols-1 gap-6">
          <.card
            icon="hero-square-3-stack-3d-solid"
            title="Bearbetning 2025-Q1"/>
          <div class="bg-white rounded-xl h-80 w-full p-6 shadow-xl mt-2 -z-9">
            <div class="text-xl font-semibold">
              <.icon name="hero-circle-stack-solid" class="w-5 h-5 mr-1"/>
              Delade data
            </div>
            <div class="divider mt-1"></div>
            <.live_component
              module={PortalWeb.Counter}
              id={@counter_id}/>
          </div>
        </div>

        <div class="h-16"></div>
      </main>
      <div
        id="stop-dispatcher"
        phx-hook="StopDispatcher">
        <!-- Only used to stop the topbar page-loading indicator -->
      </div>
    </div>
    """
  end
end
