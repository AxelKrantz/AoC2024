defmodule AdventOfCode.Day04 do
  def part1(_args) do
    input = AdventOfCode.Input.get!(4)
    lines = String.split(input, "\n") |> Enum.map(&String.trim/1)

   IO.puts(count_occurrences(lines, "XMAS"))
  end

  def part2(_args) do
  end

  def transpose(strings) do
    max_length = Enum.map(strings, &String.length/1) |> Enum.max()

    strings
    |> Enum.map(&String.trim/1)
    |> Enum.reject(&(&1 == "")) # Remove empty rows
    |> Enum.map(&String.pad_trailing(&1, max_length)) # Pad rows to equal length
    |> Enum.map(&String.graphemes/1) # Split into characters
    |> Enum.zip() # Transpose rows into columns
    |> Enum.map(&Tuple.to_list/1) # Convert tuples to lists
    |> Enum.map(&Enum.join/1) # Join lists back into strings
  end

  def count_occurrences(strings, word) do
    # Include both the word and its reverse
    reverse_word = String.reverse(word)

    row_count = count_in_lines(strings, word) + count_in_lines(strings, reverse_word)

    column = transpose(strings)
    column_count = count_in_lines(column, word) + count_in_lines(column, reverse_word)

    diagonal = transpose_45(strings)
    other_diagonal = transpose_minus_45(strings)

    diagonal_count = count_in_lines(diagonal, word) + count_in_lines(diagonal, reverse_word)
    other_diagonal_count = count_in_lines(other_diagonal, word) + count_in_lines(other_diagonal, reverse_word)
    IO.puts("Row count #{row_count}")
    IO.puts("Column count #{column_count}")
    IO.puts("Diagonal count #{diagonal_count}")
    IO.puts("Other diagonal count #{other_diagonal_count}")
    row_count + column_count + diagonal_count + other_diagonal_count
  end

  defp count_in_lines(lines, word) do
    Enum.reduce(lines, 0, fn line, acc ->
      acc + count_in_line(line, word)
    end)
  end

  defp count_in_line(line, word) do
    Regex.scan(~r/#{word}/, line) |> length()
  end

  def transpose_45(lines) do
    lines
    |> Enum.map(&String.graphemes/1) # Split lines into graphemes
    |> Enum.with_index() # Add row indices
    |> Enum.flat_map(fn {row, row_idx} ->
      Enum.with_index(row)
      |> Enum.map(fn {char, col_idx} -> {row_idx + col_idx, char} end) # Group by diagonal index
    end)
    |> Enum.group_by(fn {diagonal_idx, _char} -> diagonal_idx end, fn {_diagonal_idx, char} -> char end)
    |> Enum.sort_by(fn {diagonal_idx, _chars} -> diagonal_idx end) # Sort by diagonal index
    |> Enum.map(fn {_diagonal_idx, chars} -> Enum.join(chars) end) # Join characters into strings
  end

  def transpose_minus_45(lines) do
    lines
    |> Enum.map(&String.graphemes/1) # Split lines into graphemes
    |> Enum.with_index() # Add row indices
    |> Enum.flat_map(fn {row, row_idx} ->
      Enum.with_index(row) |> Enum.map(fn {char, col_idx} -> {{row_idx - col_idx}, char} end)
    end)
    |> Enum.group_by(fn {diagonal_idx, _char} -> diagonal_idx end, fn {_diagonal_idx, char} -> char end)
    |> Enum.sort_by(fn {diagonal_idx, _chars} -> diagonal_idx end)
    |> Enum.map(fn {_diagonal_idx, chars} -> Enum.join(chars) end)
  end
end
