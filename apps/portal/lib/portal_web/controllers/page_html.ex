defmodule PortalWeb.PageHTML do
  @moduledoc """
  This module contains pages rendered by PageController.

  See the `page_html` directory for all templates available.
  """
  use PortalWeb, :html

  embed_templates "page_html/*"

  def my_fun(assigns) do
    ~H"""
    <h1>{GenUi.hello} - {GenLib.hello}</h1>
    """
  end
end
