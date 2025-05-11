defmodule PortalWeb.WorkHTML do
  use PortalWeb, :html

  embed_templates "work_html/*"

  def my_work_fun(assigns) do
    ~H"""
    <h1>Hello, {GenUi.hello} - Hello, {GenLib.hello}</h1>
    """
  end
end
