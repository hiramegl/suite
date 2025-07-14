defmodule AkuWeb.Live.Toolbar do
  use Phoenix.Component

  import GenUi.Icon
  import GenUi.Button

  def body_class(false), do: "bg-base-100"
  def body_class(true),  do: "bg-red-100"

  attr :show_svcs, :boolean, required: true

  def toolbar(assigns) do
    ~H"""
    <div class={"navbar sticky top-0 #{@show_svcs |> body_class}"}>
      <div class="flex-1">
        <.button
          icon="hero-home-solid"
          text="Hem"
          selected={true}/>
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
        <.button
          icon="hero-calendar-days-solid"
          text="Planering"/>
        <.button
          icon="hero-inbox-arrow-down-solid"
          text="Insamling"/>
        <.button
          icon="hero-square-3-stack-3d-solid"
          text="Bearbetning"/>
        <.button
          icon="hero-presentation-chart-bar-solid"
          text="Analys"/>
        <.button
          icon="hero-newspaper-solid"
          text="Rapportering"/>
        <.button
          icon="hero-scale-solid"
          text="Utvärdering"/>
      </div>

      <div class="flex-none">
        <.button icon="hero-wrench-screwdriver-solid"/>
        <.button icon="hero-chat-bubble-left-right-solid"/>
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
    """
  end
end
