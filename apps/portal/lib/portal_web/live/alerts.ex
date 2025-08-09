defmodule PortalWeb.Live.Alerts do
  use Phoenix.Component

  import GenUi.Icon
  import PortalWeb.Live.UiUtils

  def get_overlay_classes() do
    "fixed overflow-hidden z-20 bg-gray-900 bg-opacity-25 inset-0 transform ease-in-out"
  end
  def get_overlay_toggle_classes(true) do
    "transition-all opacity-100 duration-500 translate-x-0"
  end
  def get_overlay_toggle_classes(false) do
    "transition-all opacity-0 duration-500 delay-200 translate-x-full"
  end

  def get_content_classes() do
    "w-80 md:w-96 right-0 absolute bg-base-100 h-full shadow-xl"
  end

  attr :show_svcs,   :boolean, required: true
  attr :show_alerts, :boolean, required: true

  def alerts(assigns) do
    ~H"""
    <div
      class={"#{get_overlay_classes()} #{get_overlay_toggle_classes(@show_alerts)}"}>
      <section class={"#{get_content_classes()} #{@show_svcs |> body_class}"}>
        <div class="relative pb-5 flex flex-col h-full">
          <div class="navbar flex pl-4 pr-4 shadow-md ">
            <button
              class="float-left btn btn-circle btn-outline btn-sm"
              phx-click="toggle_alerts"
              phx-value-show-alerts="false">
              <.icon name="hero-x-mark"/>
            </button>
            <span class="ml-2 font-bold text-xl">Notifieringar</span>
          </div>
          <div class="overflow-y-scroll pl-4 pr-4">
            <div class="flex flex-col w-full">
              <div class="grid mt-3 card rounded-box p-3 bg-teal-100">
                <span>
                  <.icon
                    class="mr-1"
                    name="hero-chat-bubble-left-ellipsis"/>
                  Du fick ett meddelande från Erik
                </span>
              </div>
              <div class="grid mt-3 card bg-base-200 rounded-box p-3 bg-purple-100">
                <span>
                  <.icon
                    class="mr-1"
                    name="hero-inbox-arrow-down"/>
                  <b>AKU</b>: Månadens insamling börjar nästa vecka
                </span>
              </div>
              <div class="grid mt-3 card bg-base-200 rounded-box p-3 bg-orange-100">
                <span>
                  <.icon
                    class="mr-1"
                    name="hero-user-group"/>
                  <b>ULF</b>: Urvalet kontrolleras på fredag
                </span>
              </div>
            </div>
          </div>
        </div>
      </section>
      <section class="w-screen h-full cursor-pointer"></section>
    </div>
    """
  end
end
