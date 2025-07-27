defmodule PortalWeb.Live.Dashboard do
  use Phoenix.Component

  import GenUi.Icon
  import GenUi.Button

  import PortalWeb.Live.{
    UiUtils,
    Home,
    Schema,
    Vacations,
    Links,
    Reports,
  }

  attr :dash_view,  :string,  required: true
  attr :counter_id, :string,  required: true
  attr :show_svcs,  :boolean, required: true

  def dashboard(assigns) do
    ~H"""
    <div>
      <div class={"navbar sticky top-0 #{@show_svcs |> body_class}"}>
        <div class="flex-1">
          <.button
            icon="hero-home-solid"
            text="Hem"
            selected={@dash_view == "home"}
            phx-click="view_selected"
            phx-value-view="home"/>
          <.button
            icon="hero-calendar-days-solid"
            text="Intervju schema"
            selected={@dash_view == "schema"}
            phx-click="view_selected"
            phx-value-view="schema"/>
          <.button
            icon="hero-rocket-launch-solid"
            text="Semester"
            selected={@dash_view == "vacations"}
            phx-click="view_selected"
            phx-value-view="vacations"/>
          <.button
            icon="hero-link"
            text="Mina länkar"
            selected={@dash_view == "links"}
            phx-click="view_selected"
            phx-value-view="links"/>
          <.button
            icon="hero-newspaper-solid"
            text="Rapporter"
            selected={@dash_view == "reports"}
            phx-click="view_selected"
            phx-value-view="reports"/>
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
        <%= if @dash_view == "home" do %>
          <.home counter_id={@counter_id}/>
        <% end %>
        <%= if @dash_view == "schema" do %>
          <.schema/>
        <% end %>
        <%= if @dash_view == "vacations" do %>
          <.vacations/>
        <% end %>
        <%= if @dash_view == "links" do %>
          <.links/>
        <% end %>
        <%= if @dash_view == "reports" do %>
          <.reports/>
        <% end %>

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
