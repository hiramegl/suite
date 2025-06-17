defmodule PortalWeb.Live.ServiceItem do
  use Phoenix.Component
  import GenUi.Icon

  attr :id,   :string, required: true
  attr :name, :string, required: true
  attr :icon, :string, required: true
  attr :selected, :boolean, default: false
  def service_item(assigns) do
    ~H"""
    <li class="">
      <span
        class={"font-semibold #{if @selected == "true", do: "bg-base-200"}"}
        aria-current="page"
        phx-click="svc_change"
        phx-value-service={@id}>
        <.icon
          name={@icon}
          class="h-6 w-6"/>
        {@name}
        <%= if @selected == "true" do %>
        <span
          class="absolute inset-y-0 left-0 w-1 rounded-tr-md rounded-br-md bg-primary"
          aria-hidden="true"></span>
        <% end %>
      </span>
    </li>
    """
  end
end
