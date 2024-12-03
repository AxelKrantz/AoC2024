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
    prefix = "do()"

    input =
      prefix <> input

    validate_expression(input, 0)
  end

  def validate_expression(string, sum) do
    IO.puts("Current sum: #{sum}")

    case Regex.run(~r/(.*?mul\(\d{1,3},\d{1,3}\))(.*)/, string, capture: :all_but_first) do
      result when is_list(result) ->
        [matched, leftover] = result

        conditionals =
          Regex.scan(~r/do\(\)|don't\(\)/, matched)
          |> Enum.map(&hd/1)

        if last_is_do?(conditionals) do
          IO.inspect("Conditionals: #{conditionals}")
          new_sum = scan(matched) + sum
          validate_expression(leftover, new_sum)
        else
          validate_expression(leftover, sum)
        end

      nil ->
        IO.puts("No match found.")
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
