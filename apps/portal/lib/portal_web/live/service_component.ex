defmodule ServiceComponent do
  use Phoenix.LiveComponent

  def render(assigns) do
    ~H"""
    <div>
      <script
        type="text/javascript"
        src={"/#{@service}/assets/#{@service}-main.js"}></script>
      <.dynamic_tag
        tag_name={"#{@service}-main"}
        id={"#{@service}-container"}></.dynamic_tag>
      <script
        phx-track-static
        type="text/javascript"
        src={"#{@service}/assets/app.js"}></script>
    </div>
    """
  end
end
