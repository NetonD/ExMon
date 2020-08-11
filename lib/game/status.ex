defmodule ExMon.Game.Status do
  alias ExMon.Game
  def print_round_message() do
    IO.puts("============= GAME's STARTED ============= ")

    Game.info()
    |>IO.inspect()
    IO.puts("------------------------------------------")
  end

  def print_wrong_move(move) do
    IO.puts("=============== Invalid movement key. [MOVE] #{move}.")
  end
end
