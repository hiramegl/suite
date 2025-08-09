defmodule PortalWeb.Live.Title do
  use Phoenix.Component

  alias Phoenix.LiveView.JS

  def show_sidebar(js \\ %JS{}) do
    js
    |> JS.remove_class("hidden", to: "#sidebar")
    |> JS.add_class("drawer-side", to: "#sidebar")
    |> JS.add_class("drawer", to: "#main-viewport")
    |> JS.add_class("lg:hidden", to: "#drawer-toggle")
  end

  attr :title, :string, required: true

  def title(assigns) do
    ~H"""
    <div class="flex-1">
      <div
        id="drawer-toggle"
        for="left-sidebar"
        class="drawer-button mr-2 cursor-pointer lg:hidden"
        phx-click={show_sidebar()}>
        <div class="indicator">
          <img
            class="ml-2 mask mask-squircle w-10"
            src="/images/scb_logo_192.jpg"
            alt="Portal Logo"/>
          <span class="indicator-item badge badge-accent badge-sm">
            QA
          </span>
        </div>
      </div>
      <h1 class="text-2xl font-semibold ml-2">
        {@title}
      </h1>
    </div>
    """
  end
end
