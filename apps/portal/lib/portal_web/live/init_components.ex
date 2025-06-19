defmodule PortalWeb.Live.InitComponents do
  use Phoenix.Component

  attr :services, :list, required: true
  def init_components(assigns) do
    ~H"""
    <%= for svc <- @services do %>
      <script
        type="text/javascript"
        src={"/#{svc}/assets/#{svc}-main.js"}></script>
    <% end %>
    """
  end
end
