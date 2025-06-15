defmodule ServiceItemComponent do
  use Phoenix.LiveComponent
  import PortalWeb.CoreComponents, only: [icon: 1]

  attr :name, :string
  attr :icon, :string
  attr :selected, :boolean, default: false

  def render(assigns) do
    ~H"""
    <li class="">
      <span
        class={"font-semibold #{if @selected == "true", do: "bg-base-200"}"}
        href="/aku"
        aria-current="page">
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
