defmodule SidebarTopComponent do
  use Phoenix.LiveComponent

  def render(assigns) do
    ~H"""
    <li class="mb-2 font-semibold text-xl">
      <a
        href="/app/welcome"
        class="bg-green-100">
        <img
          class="mask mask-squircle w-10"
          src="/images/scb_logo_192.jpg"
          alt="Portal Logo"/>
        Portal
        <div class="badge badge-accent">QA</div>
      </a>
    </li>
    """
  end
end
