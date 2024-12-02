defmodule AOCUtils do
  def lines_from_text(input) do
    input
    |> String.split("\n", trim: true)
  end
end
