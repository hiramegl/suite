defmodule PortalIntWeb.WorkController do
  use PortalIntWeb, :controller

  # https://developer.mozilla.org/en-US/docs/Web/HTTP/Reference/Headers/Accept-Encoding
  def work(conn, _params) do
    conn
    |> render(:work)
  end
end
