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

  def print_message_move(:computer, :attack, damage) do
    IO.puts("!!============= Player dealing on computer #{damage} damage. =============!!")
  end

  def print_message_move(:player, :attack, damage) do
    IO.puts("!!============= Computer dealing on player #{damage} damage. =============!!")
  end
end
