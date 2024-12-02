defmodule AdventOfCode.Day02 do
  import AOCUtils
  import AdventOfCode.Input

  def part1(_args) do
    get!(2)
    |> lines_from_text()
    |> Enum.map(&split_string/1)
    |> Enum.map(&string_to_ints/1)
    |> Enum.filter(&is_ordered/1)
    |> Enum.filter(&valid_step?/1)
    |> Enum.count()
  end

  def part2(_args) do
    get!(2)
    |> lines_from_text()
    |> Enum.map(&split_string/1)
    |> Enum.map(&string_to_ints/1)
  end

  def valid_step?(list) do
    list
    |> Enum.zip(tl(list))
    |> Enum.all?(fn {a, b} -> b - a >= 1 and b - a <= 3 end)
  end

  def is_ordered(list) do
    asc = Enum.sort(list)
    desc = Enum.sort(list, :desc)

    cond do
      list == asc -> list
      list == desc -> Enum.reverse(list)
      true -> nil
    end
  end

  def split_string(string) do
    String.split(string, " ", trim: true)
  end

  def string_to_ints(line) do
    line
    |> Enum.map(&String.to_integer/1)
  end
end
