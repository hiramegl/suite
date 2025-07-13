defmodule PortalWeb.Live.Container do
  use Phoenix.Component

  attr :service, :string, required: true
  attr :show_svcs, :boolean, required: true
  def container(assigns) do
    ~H"""
    <div>
      <.dynamic_tag
        tag_name={"#{@service}-main"}
        id={"#{@service}-container"}
        data-show-svcs={if @show_svcs, do: "true", else: "false"}></.dynamic_tag>
      <script id="main-script"></script>
    </div>
    """
  end
end
