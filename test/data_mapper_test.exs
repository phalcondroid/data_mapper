defmodule DataMapperTest do
  use ExUnit.Case
  doctest DataMapper

  test "greets the world" do
    assert DataMapper.hello() == :world
  end
end
