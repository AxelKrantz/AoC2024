defmodule AdventOfCode.Day01 do
  import AOCUtils

  def part1(_input) do
    AdventOfCode.Input.get!(1)
    |> lines_from_text()
    |> Enum.map(&String.split(&1, ~r/\s+/, trim: true))
    |> Enum.map(fn [a, b] -> {String.to_integer(a), String.to_integer(b)} end)
    |> Enum.unzip()
    |> then(fn {first_list, second_list} ->
      first_list = Enum.sort(first_list)
      second_list = Enum.sort(second_list)

      Enum.zip(first_list, second_list)
      |> Enum.map(fn {a, b} -> abs(a - b) end)
    end)
    |> Enum.sum()
  end

  def part2(_input) do
    AdventOfCode.Input.get!(1)
    |> lines_from_text()
    |> Enum.map(&String.split(&1, ~r/\s+/, trim: true))
    |> Enum.map(fn [a, b] -> {String.to_integer(a), String.to_integer(b)} end)
    |> Enum.unzip()
    |> then(fn {first_list, second_list} ->
      first_list
      |> Enum.map(fn number ->
        count = Enum.count(second_list, fn x -> x == number end)
        number * count
      end)
    end)
    |> Enum.sum()
  end
end
