defmodule AdventOfCode.Day02 do
  import AdventOfCode.Input

  def part1(_args) do
    get!(2)
    |> parse()
    |> Enum.filter(&safe?/1)
    |> length()
  end

  def part2(_args) do
    get!(2)
    |> parse()
    |> Enum.filter(&safeish?/1)
    |> Enum.count()
  end

  defp parse(input) do
    input
    |> String.split("\n", trim: true)
    |> Enum.map(&parse_line/1)
  end

  defp parse_line(line) do
    Enum.map(String.split(line, " "), &String.to_integer/1)
  end

  defp safe?([a, b | _] = list) when a < b, do: safe?(:asc, list)
  defp safe?([a, b | _] = list) when a > b, do: safe?(:desc, list)
  defp safe?([a, a | _]), do: false
  defp safe?(:asc, [a, b | rest]) when abs(a - b) in 1..3 and a < b, do: safe?(:asc, [b | rest])
  defp safe?(:desc, [a, b | rest]) when abs(a - b) in 1..3 and a > b, do: safe?(:desc, [b | rest])
  defp safe?(_, [_last]), do: true
  defp safe?(_, _), do: false

  defp safeish?(list) do
    candidates = [list | Enum.map(0..(length(list) - 1), &List.delete_at(list, &1))]
    Enum.any?(candidates, &safe?/1)
  end
end
