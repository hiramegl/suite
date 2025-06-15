defmodule TitleComponent do
  use Phoenix.LiveComponent
  import PortalWeb.CoreComponents, only: [icon: 1]

  attr :title, :string

  def render(assigns) do
    ~H"""
    <div class="flex-1">
      <label
        for="left-sidebar-drawer"
        class="btn btn-primary drawer-button lg:hidden">
        <.icon name="hero-bars-3-solid" class="h-6 w-6"/>
      </label>
      <h1 class="text-2xl font-semibold ml-2">
        {@title}
      </h1>
    </div>
    """
  end
end
