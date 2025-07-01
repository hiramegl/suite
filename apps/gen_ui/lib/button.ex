defmodule GenUi.Button do
  use Phoenix.Component
  import GenUi.Icon

  attr :icon,     :string, required: true
  attr :text,     :string, required: true
  attr :selected, :boolean, default: false
  def button(assigns) do
    ~H"""
    <button
      type="button"
      class={"btn text-xl ml-2 #{if @selected, do: "btn-primary"}"}>
      <.icon
        name={@icon}
        class="w-5 h-5"/>
      {@text}
    </button>
    """
  end
end
