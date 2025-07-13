defmodule PortalWeb.Live.UiUtils do
  def body_class(false), do: "bg-base-100"
  def body_class(true),  do: "bg-blue-100"

  def main_class(false), do: "bg-base-200"
  def main_class(true),  do: "bg-blue-200"
end
