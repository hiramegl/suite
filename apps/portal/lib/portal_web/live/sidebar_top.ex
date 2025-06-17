defmodule PortalWeb.Live.SidebarTop do
  use Phoenix.Component

  def sidebar_top(assigns) do
    ~H"""
    <li class="mb-2 font-semibold text-xl">
      <div class="bg-green-100">
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
