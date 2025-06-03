defmodule InitComponents do
  use Phoenix.Component

  attr :svcs, :list
  def render(assigns) do
    ~H"""
    <%= for svc <- @svcs do %>
      <script
        type="text/javascript"
        src={"/#{svc}/assets/#{svc}-main.js"}></script>
    <% end %>
    """
  end
end
