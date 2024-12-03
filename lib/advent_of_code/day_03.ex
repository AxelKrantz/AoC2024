defmodule AdventOfCode.Day03 do
  def part1(_args) do
    input = AdventOfCode.Input.get!(3)
    regex = ~r/mul\(\d+,\d+\)/
    secex = ~r/\d+/

    Regex.scan(regex, input)
    |> Enum.map(fn [match] ->
      numbers = Regex.scan(~r/\d+/, match) |> List.flatten()
      [a, b] = Enum.map(numbers, &String.to_integer/1)
      a * b
    end)
    |> Enum.sum()
  end

  def part2(_args) do
  end
end
