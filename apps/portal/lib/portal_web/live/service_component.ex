defmodule ServiceComponent do
  use Phoenix.LiveComponent

  def render(assigns) do
    ~H"""
    <div>
      <iframe
        src={"/#{assigns.service}/init"}
        style="display: none"></iframe>
      <.dynamic_tag
        tag_name={"#{assigns.service}-main"}
        id={"#{assigns.service}-container"}></.dynamic_tag>
      <script
        phx-track-static
        type="text/javascript"
        src={"#{assigns.service}/assets/app.js"}></script>
    </div>
    """
  end
end
