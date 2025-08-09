defmodule PortalWeb.Live.NavbarTools do
  use Phoenix.LiveComponent
  import PortalWeb.CoreComponents, only: [icon: 1]

  attr :alert, :string, required: true

  def navbar_tools(assigns) do
    ~H"""
      <div class="flex-none">
        <div class="badge badge-primary badge-outline">{@alert}</div>
        <button
          class="btn btn-ghost btn-circle"
          phx-click="toggle_alerts"
          phx-value-show-alerts="true">
          <div class="indicator">
            <.icon name="hero-bell-solid" class="h-6 w-6"/>
            <span class="indicator-item badge badge-secondary badge-sm">
              3
            </span>
          </div>
        </button>

        <div class="ml-6">
          <div class="text-l font-semibold grid place-content-center">
            SCBHIGA
          </div>
          <div class="text-sm grid place-content-center">
            IT/SV/VA
          </div>
        </div>
        <div class="dropdown dropdown-end ml-2">
          <div
            tabindex="0"
            class="btn btn-ghost btn-circle avatar">
            <div class="w-10 rounded-full">
              <img
                src="/images/profile.jpg"
                alt="profile">
            </div>
          </div>
          <ul
            tabindex="0"
            class="menu menu-compact dropdown-content mt-3 p-2 shadow bg-base-100 rounded-box w-52 z-100">
            <li class="justify-between">
              <a href="/app/settings-profile">Profile Settings
                <span class="badge badge-primary">New</span>
              </a>
            </li>
            <div class="divider mt-0 mb-0"></div>
            <li>
              <a>Logout</a>
            </li>
          </ul>
        </div>
      </div>
    """
  end

end
