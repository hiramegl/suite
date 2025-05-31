defmodule PortalWeb.InitController do
  use PortalWeb, :controller

  def init(conn, _params) do
    get_csrf_token() # set the cross-site request forgery cookie
    html(conn, ~s(INIT:OK))
  end
end
