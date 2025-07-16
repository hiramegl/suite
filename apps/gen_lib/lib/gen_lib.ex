defmodule GenLib do
  use Phoenix.LiveView

  def hello do
    :world_lib
  end

  def get_present(
    socket,
    presence_module,
    endpoint_module,
    presence_topic) do
    if socket |> connected? do
      self()
      |> presence_module.track(
        presence_topic,
        socket.id,
        %{})

      presence_topic
      |> endpoint_module.subscribe

      presence_topic
      |> presence_module.list
      |> map_size
    else
      0
    end
  end

  def get_show_svcs(
    socket,
    params) do
    show_svcs_str = if socket |> get_connect_params == nil do
      # no socket params means GET request, use request params
      params
      |> Map.get("show-svcs", "false")
    else
      # socket params exists, read value from socket params
      socket
      |> get_connect_params
      |> Map.get("show_svcs", "false")
    end

    show_svcs_str == "true"
  end
end
