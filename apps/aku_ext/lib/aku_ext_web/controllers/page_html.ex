defmodule AkuExtWeb.PageHTML do
  @moduledoc """
  This module contains pages rendered by PageController.

  See the `page_html` directory for all templates available.
  """
  use AkuExtWeb, :html

  embed_templates "page_html/*"

  def hello_fun(assigns) do
    ~H"""
    <h1>AKU EXT! GenUI: {GenUi.hello}, GenLib: {GenLib.hello}</h1>
    """
  end
end
