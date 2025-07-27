defmodule PortalWeb.Live.Home do
  use Phoenix.Component

  import GenUi.Card
  import GenUi.Icon

  attr :counter_id, :string, required: true

  def home(assigns) do
    ~H"""
    <div>
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
    </div>
    """
  end
end
