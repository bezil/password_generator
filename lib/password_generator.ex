defmodule PasswordGenerator do
  @moduledoc """
  Documentation for `PasswordGenerator`.

  generate random password
  ------------------------
  parameters needed to generate includes:
  1. length(number)
  2. numbers(boolean) // Coming soon
  3. uppercase(boolean) // Coming soon
  4. symbols(boolean)** // Coming soon
  """

# @allowed_options [:length, :numbers, :uppercase, :symbols]

  @doc """
  Generate string for random password.

  ## Examples
    options = %{
      "length" => "4"
    }

    PasswordGenerator.generate(options)
    {:ok, "Valid parameters"}
  """
  @spec generate(options :: map()) :: {:ok, bitstring()} | {:error, bitstring()}
  def generate(options) do
    length = Map.has_key?(options, "length")
    case length do
      true -> validateLength(options["length"], options)
      false -> {:error, "Please provide length parameter"}
    end
  end

  defp validateLength(lengthValue, options) do
    numbers = Enum.map(0..9, & Integer.to_string(&1))
    length = String.contains?(lengthValue, numbers)
    case length do
      true -> validateOthers(options)
      false -> {:error, "Only integers are allowed for length parameter"}
    end
  end

  defp validateOthers(options) do
    options_without_length = Map.delete(options, "length") |> Map.values()
    value = options_without_length |> Enum.all?(fn x -> String.to_atom(x) |> is_boolean() end)
    lengthValue = String.to_integer(options["length"])
    case value do
      true -> generate_random_string(lengthValue)
      false -> {:error, "Other parameters except length should be boolean value"}
    end
  end

  defp generate_random_string(length) when is_integer(length) and length > 0 do
    charset = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
    random_characters = charset
    |> String.to_charlist()
    |> Enum.shuffle()
    |> Enum.take(length)
    |> List.to_string()
    {:ok, random_characters}
  end
end
