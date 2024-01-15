defmodule PasswordGeneratorTest do
  use ExUnit.Case
  doctest PasswordGenerator

  test "validate length parameter" do
    options = %{
      "length" => "5"
    }
    {:ok, result} = PasswordGenerator.generate(options)
    assert String.length(result) == 5
  end

  test "validate other parameters" do
    options = %{
      "length" => "5",
      "uppercase" => "true"
    }
    {:ok, result} = PasswordGenerator.generate(options)
    assert String.length(result) == 5
  end

  test "validate length parameter (error case 1)" do
    options = %{
      "length" => "five"
    }
    assert PasswordGenerator.generate(options) == {:error, "Only integers are allowed for length parameter"}
  end

  test "validate length parameter (error case 2)" do
    options = %{
      "uppercase" => "4"
    }
    assert PasswordGenerator.generate(options) == {:error, "Please provide length parameter"}
  end

  test "validate length parameter (error case 3)" do
    options = %{
      "length" => "5",
      "uppercase" => "ok"
    }
    assert PasswordGenerator.generate(options) == {:error, "Other parameters except length should be boolean value"}
  end
end
