defmodule AdventOfCode.Day04 do
  def part1(_args) do
    input = AdventOfCode.Input.get!(4)

    lines = String.split(input, "\n")

    count = count_occurrences(lines, "XMAS")
    IO.inspect(count, label: "Total Count")
  end

  def part2(_args) do
  end

  def transpose(strings) do
    strings
    # Convert rows to lists of characters
    |> Enum.map(&String.graphemes/1)
    |> Enum.zip()
    |> Enum.map(&Tuple.to_list/1)
    |> Enum.map(&Enum.join/1)
  end

  def count_occurrences(strings, word) do
    # Include both the word and its reverse
    reverse_word = String.reverse(word)

    row_count = count_in_lines(strings, word) + count_in_lines(strings, reverse_word)

    column_count =
      count_in_lines(transpose(strings), word) + count_in_lines(transpose(strings), reverse_word)

    row_count + column_count
  end

  defp count_in_lines(lines, word) do
    Enum.reduce(lines, 0, fn line, acc ->
      acc + count_in_line(line, word)
    end)
  end

  defp count_in_line(line, word) do
    Regex.scan(~r/#{word}/, line) |> length()
  end
end
