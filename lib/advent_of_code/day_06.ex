defmodule AdventOfCode.Day06 do

  def part1(_args) do
    input = AdventOfCode.Input.get!(6)
    test_input = string_to_2d_array(input)
    rotated = rotate_counter_clockwise(test_input)
    rotated_again = rotate_counter_clockwise(rotated)
    final_rotate = rotate_counter_clockwise(rotated_again)
    position = find_position(final_rotate)
    move(position, final_rotate)
    |> count_x()
  end

  defp move(position, map) do
    {row, col} = position

    # Start moving right, but stop one step before '#'
    move_right({row, col}, map)
  end

  defp move_right({row, col}, map) do
    # Check if the position is out of bounds (no more columns to move)
      current_value = Enum.at(Enum.at(map, row), col)

      if col >= length(Enum.at(map, 0)) do
        # Return map as is if we move out of bounds
        map
      else
      case current_value do
        "." ->
          #IO.inspect("Current Value #{current_value}")
          # Mark as visited by changing '.' to 'X'
          updated_map = update_map(map, row, col, "X")
          # Check next position, if it's '#' stop, otherwise continue moving
          next_value = Enum.at(Enum.at(map, row), col + 1)
          if next_value != "#" do
            # Move to the next column
            #IO.puts("Next !#")
            move_right({row, col + 1}, updated_map)
          else
            #IO.puts("Rotate")
            {new_row, new_col} = update_position_to_rotation({row, col}, updated_map)
            rotated_map = rotate_counter_clockwise(updated_map)
            move_right({new_row, new_col}, rotated_map)
          end

        "#" ->
          # If we encounter '#', stop the movement
          map

        _ ->
          move_right({row, col + 1}, map)
      end
    end
  end

  defp update_position_to_rotation({col, row}, map) do
    total_rows = length(map)

    # New position after rotating 90 degrees counterclockwise
    new_row = col
    new_col = total_rows - row - 1

    {new_col, new_row}
  end

  def rotate_counter_clockwise(matrix) do
    matrix
    |> Enum.zip()
    |> Enum.map(&Tuple.to_list(&1))
    |> Enum.reverse()
  end

  # Update the map at a specific row and column
  defp update_map(map, row, col, new_value) do
    # Replace the value at the specific row and column with new_value
    row_data = Enum.at(map, row)
    updated_row = List.replace_at(row_data, col, new_value)
    List.replace_at(map, row, updated_row)
  end

  def count_x(matrix) do
    matrix
    |> Enum.flat_map(& &1)  # Flatten the 2D array into a 1D list
    |> Enum.count(fn x -> x == "X" end)  # Count occurrences of "X"
  end

  def find_position(map) do
    Enum.find_value(map, fn row ->
      case Enum.find_index(row, fn char -> char == "^" end) do
        nil -> nil
        col_index -> {Enum.find_index(map, &(&1 == row)), col_index}
      end
    end)
  end

  def part2(_args) do
  end

  def string_to_2d_array(input) do
    input
    |> String.split("\n", trim: true)
    |> Enum.map(&String.graphemes/1)
  end


end
