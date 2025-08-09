defmodule UlfWeb.Live.Home do
  use Phoenix.Component

  import GenUi.Card
  import GenUi.Icon

  attr :counter_id, :string,  required: true
  attr :present,    :integer, required: true

  def home(assigns) do
    ~H"""
    <div>
      <div class="grid lg:grid-cols-4 grid-cols-1 gap-6">
        <.card
          icon="hero-square-3-stack-3d"
          title="Bearbetning 2025-Q1"/>
        <.card
          icon="hero-square-3-stack-3d"
          title="Bearbetning 2024-Q3"/>
        <div class="bg-white rounded-xl h-80 w-full p-6 shadow-xl mt-2">
          <div class="text-xl font-semibold">
            <.icon
              name="hero-presentation-chart-bar-solid"
              class="w-5 h-5 mr-1"/>
            Analys 2024-Q4
          </div>
          <div class="divider mt-1"></div>
          <img
            src="/ulf/images/chart01.jpg"
            class="h-52 ml-12"/>
        </div>
        <.card
          icon="hero-calendar-days"
          title="Planering 2025-Q4"/>
      </div>

      <div class="grid lg:grid-cols-4 grid-cols-1 gap-6">
        <div class="bg-white rounded-xl h-80 w-full p-6 shadow-xl mt-2">
          <div class="text-xl font-semibold">
            <.icon name="hero-circle-stack-solid" class="w-5 h-5 mr-1"/>
            Delade data
          </div>
          <div class="divider mt-1"></div>
          <.live_component
            module={UlfWeb.Counter}
            id={@counter_id}/>
          <div>
            Antal anslutna: <span class="badge badge-accent"><%= @present %></span>
          </div>
        </div>
        <.card
          class="bg-red-50"
          icon="hero-envelope"
          title="Viktiga meddelande"/>
        <.card
          icon="hero-square-3-stack-3d"
          title="Bearbetning 2024-Q4"/>
        <.card
          icon="hero-presentation-chart-bar"
          title="Analys 2025-Q1"/>
      </div>

      <div class="grid lg:grid-cols-4 grid-cols-1 gap-6">
        <.card
          icon="hero-square-3-stack-3d"
          title="Bearbetning 2024-Q1"/>
        <.card
          icon="hero-presentation-chart-bar"
          title="Analys 2024-Q3"/>
        <.card
          class="bg-teal-50"
          icon="hero-chat-bubble-left-right"
          title="Konversation med Erik"/>
        <.card
          icon="hero-calendar-days"
          title="Planering 2025-Q3"/>
      </div>
    </div>
    """
  end
end
