defmodule AdventOfCode.Day03 do
  def part1(_args) do
    input = AdventOfCode.Input.get!(3)
    scan(input)
  end

  def scan(input) do
    regex = ~r/mul\(\d+,\d+\)/

    Regex.scan(regex, input)
    |> Enum.map(fn [match] ->
      numbers = Regex.scan(~r/\d+/, match) |> List.flatten()
      [a, b] = Enum.map(numbers, &String.to_integer/1)
      a * b
    end)
    |> Enum.sum()
  end

  def part2(_args) do
    input = AdventOfCode.Input.get!(3)

    find_data(:enabled, input, 0)
  end

  def find_data(:disabled, string, sum) do
    case Regex.run(~r/.*?do\(\)(.*)/, string, capture: :all_but_first) do
      [rest] -> find_data(:enabled, rest, sum)
      nil -> sum
    end
  end

  def find_data(:enabled, string, sum) do
    case Regex.run(~r/.*?(don't\(\)|mul\(\d+,\d+\))(.*)/, string, capture: :all_but_first) do
      [first_match, rest] ->
        case first_match do
          "don't()" ->
            find_data(:disabled, rest, sum)

          _ ->
            new_sum = sum + scan(first_match)
            find_data(:enabled, rest, new_sum)
        end

      nil ->
        sum
    end
  end

  def last_is_do?(list) do
    case List.last(list) do
      "do()" -> true
      _ -> false
    end
  end
end
