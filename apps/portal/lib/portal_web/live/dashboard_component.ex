defmodule DashboardComponent do
  use Phoenix.LiveComponent
  import GenUi.Card
  import GenUi.Icon

  def render(assigns) do
    ~H"""
    <div>
      <div class="navbar sticky top-0">
        <div class="flex-1">
          <button class="btn btn-primary text-xl">
            <.icon name="hero-home-solid" class="w-5 h-5"/>
            Hem
          </button>
          <button class="btn text-xl ml-2">
            <.icon name="hero-calendar-days-solid" class="w-5 h-5"/>
            Intervju schema
          </button>
          <button class="btn text-xl ml-2">
            <.icon name="hero-rocket-launch-solid" class="w-5 h-5"/>
            Semester
          </button>
          <button class="btn text-xl ml-2">
            <.icon name="hero-presentation-chart-bar-solid" class="w-5 h-5"/>
            Statistik
          </button>
          <button class="btn text-xl ml-2">
            <.icon name="hero-newspaper-solid" class="w-5 h-5"/>
            Rapporter
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
          <.card
            icon="hero-square-3-stack-3d-solid"
            title="Bearbetning 2025-Q1"/>
        </div>

        <div class="h-16"></div>
      </main>
    </div>
    """
  end
end
