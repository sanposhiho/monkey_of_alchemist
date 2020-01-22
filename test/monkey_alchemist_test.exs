defmodule MonkeyAlchemistTest do
  use ExUnit.Case
  doctest MonkeyAlchemist

  test "greets the world" do
    assert MonkeyAlchemist.hello() == :world
  end
end
