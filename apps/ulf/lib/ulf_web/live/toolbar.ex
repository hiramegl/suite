defmodule UlfWeb.Live.Toolbar do
  use Phoenix.Component

  import GenUi.Icon
  import GenUi.Button

  def body_class(false), do: "bg-base-100"
  def body_class(true),  do: "bg-green-100"

  attr :show_svcs, :boolean, required: true

  def toolbar(assigns) do
    ~H"""
    <div class={"navbar sticky top-0 z-10 #{@show_svcs |> body_class}"}>
      <div class="flex-1">
        <.button
          icon="hero-home-solid"
          text="Hem"
          selected={true}/>
        <div class="dropdown ml-1">
          <div
            tabindex="0"
            role="button"
            class="btn m-1 text-xl">
            <.icon
              name="hero-calendar-solid"
              class="w-5 h-5"/>
            2025-Q1
          </div>
          <ul
            tabindex="0"
            class="dropdown-content menu bg-base-200 rounded-box z-200 w-52 p-2 shadow">
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
                <.icon
                  name="hero-archive-box-solid"
                  class="w-5 h-5"/>
                Arkiv
              </a>
            </li>
          </ul>
        </div>
        <div class="dropdown ml-1">
          <div
            tabindex="0"
            role="button"
            class="btn m-1 text-xl">
            <.icon
              name="hero-calendar-days-solid"
              class="w-5 h-5"/>
            Planering
          </div>
          <ul
            tabindex="0"
            class="dropdown-content menu bg-base-200 rounded-box w-80 p-2 shadow">
            <li>
              <details open>
                <summary><b>1. Fastställ behov</b></summary>
                <ul>
                  <li><a>1.1 Identifiera behov</a></li>
                  <li><a>1.2 Konsultera intressenter</a></li>
                  <li><a>1.3 Kontrollera datatillgång</a></li>
                </ul>
              </details>
            </li>
            <li>
              <details open>
                <summary><b>2. Utforma undersökning</b></summary>
                <ul>
                  <li><a>2.1 Utforma resultat</a></li>
                  <li><a>2.2 Utforma variabler</a></li>
                  <li><a>2.3 Utforma datafångst</a></li>
                  <li><a>2.4 Utforma kodning</a></li>
                  <li><a>2.5 Utforma statistik</a></li>
                  <li><a>2.6 Utforma redovisning</a></li>
                  <li><a>2.7 Utforma produktionsflöde</a></li>
                </ul>
              </details>
            </li>
            <li>
              <details open>
                <summary><b>3. Planera och testa</b></summary>
                <ul>
                  <li><a>3.1 Planera omgångar</a></li>
                  <li><a>3.2 Driftsätt produktionsflöde</a></li>
                </ul>
              </details>
            </li>
          </ul>
        </div>
        <div class="dropdown ml-1">
          <div
            tabindex="0"
            role="button"
            class="btn m-1 text-xl">
            <.icon
              name="hero-inbox-arrow-down-solid"
              class="w-5 h-5"/>
            Insamling
          </div>
          <ul
            tabindex="0"
            class="dropdown-content menu bg-base-200 rounded-box w-80 p-2 shadow">
            <li>
              <details open>
                <summary><b>4. Genomför datafångst</b></summary>
                <ul>
                  <li><a>4.1 Förbered datafångst</a></li>
                  <li><a>4.2 Genomför datafångst</a></li>
                  <li><a>4.3 Sammanställ datakällor</a></li>
                </ul>
              </details>
            </li>
          </ul>
        </div>
        <div class="dropdown ml-1">
          <div
            tabindex="0"
            role="button"
            class="btn m-1 text-xl">
            <.icon
              name="hero-square-3-stack-3d-solid"
              class="w-5 h-5"/>
            Bearbetning
          </div>
          <ul
            tabindex="0"
            class="dropdown-content menu bg-base-200 rounded-box w-80 p-2 shadow">
            <li>
              <details open>
                <summary><b>5. Bearbeta och framställ register</b></summary>
                <ul>
                  <li><a>5.1 Integrera datakällor</a></li>
                  <li><a>5.2 Komplettera mikrodata</a></li>
                  <li><a>5.3 Framställ observationsregister</a></li>
                </ul>
              </details>
            </li>
          </ul>
        </div>
        <div class="dropdown ml-1">
          <div
            tabindex="0"
            role="button"
            class="btn m-1 text-xl">
            <.icon
              name="hero-presentation-chart-bar-solid"
              class="w-5 h-5"/>
            Analys
          </div>
          <ul
            tabindex="0"
            class="dropdown-content menu bg-base-200 rounded-box w-80 p-2 shadow">
            <li>
              <details open>
                <summary><b>6. Framställ statistik och analysera</b></summary>
                <ul>
                  <li><a>6.1 Framställ statistikvärden</a></li>
                  <li><a>6.2 Genomför röjandekontroll</a></li>
                  <li><a>6.3 Tolka och förklara</a></li>
                  <li><a>6.4 Framställ innehåll för redovisning</a></li>
                </ul>
              </details>
            </li>
          </ul>
        </div>
        <div class="dropdown ml-1">
          <div
            tabindex="0"
            role="button"
            class="btn m-1 text-xl">
            <.icon
              name="hero-newspaper-solid"
              class="w-5 h-5"/>
            Rapportering
          </div>
          <ul
            tabindex="0"
            class="dropdown-content menu bg-base-200 rounded-box w-80 p-2 shadow">
            <li>
              <details open>
                <summary><b>7. Redovisa och kommunicera</b></summary>
                <ul>
                  <li><a>7.1 Sammanställ slutresultat</a></li>
                  <li><a>7.2 Redovisa slutresultat</a></li>
                  <li><a>7.3 Kommunicera slutresultat</a></li>
                </ul>
              </details>
            </li>
          </ul>
        </div>
        <div class="dropdown ml-1">
          <div
            tabindex="0"
            role="button"
            class="btn m-1 text-xl">
            <.icon
              name="hero-scale-solid"
              class="w-5 h-5"/>
            Utvärdering
          </div>
          <ul
            tabindex="0"
            class="dropdown-content menu bg-base-200 rounded-box w-80 p-2 shadow">
            <li>
              <details open>
                <summary><b>8. Utvärdera och gallra</b></summary>
                <ul>
                  <li><a>8.1 Utvärdera</a></li>
                  <li><a>8.2 Bevara och gallra</a></li>
                </ul>
              </details>
            </li>
          </ul>
        </div>
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
