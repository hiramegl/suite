defmodule GenUiTest do
  use ExUnit.Case
  doctest GenUi

  test "greets the world" do
    assert GenUi.hello() == :world
  end
end
