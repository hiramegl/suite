defmodule GenLibTest do
  use ExUnit.Case
  doctest GenLib

  test "greets the world" do
    assert GenLib.hello() == :world
  end
end
