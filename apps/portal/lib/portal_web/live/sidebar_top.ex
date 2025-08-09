defmodule PortalWeb.Live.SidebarTop do
  use Phoenix.Component

  alias Phoenix.LiveView.JS

  def hide_sidebar(js \\ %JS{}) do
    js
    |> JS.add_class("hidden", to: "#sidebar")
    |> JS.remove_class("drawer-side", to: "#sidebar")
    |> JS.remove_class("drawer", to: "#main-viewport")
    |> JS.remove_class("lg:hidden", to: "#drawer-toggle")
  end

  def sidebar_top(assigns) do
    ~H"""
    <li class="mb-2 font-semibold text-xl">
      <div
        class="bg-green-100"
        phx-click={hide_sidebar()}>
        <img
          class="mask mask-squircle w-10"
          src="/images/scb_logo_192.jpg"
          alt="Portal Logo"/>
        Portal
        <div class="badge badge-accent">QA</div>
      </div>
    </li>
    """
  end
end
