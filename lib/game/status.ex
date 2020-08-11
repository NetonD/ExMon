# p = ExMon.create_player("neto",:soco,:cura,:a)

defmodule ExMon.Game.Status do
  def print_round_message(%{status: :started} = state) do
    IO.puts("============= GAME's STARTED ============= ")
    IO.inspect(state)
    IO.puts("------------------------------------------")
  end

  def print_round_message(%{status: :continue, turn: player} = state) do
    IO.puts("---- Turn change <!!> now is #{player} ----")
    IO.inspect(state)
    IO.puts("------------------------------------------")
  end

  def print_round_message(%{status: :game_over} = state) do
    IO.puts("---- Game's ended. This was placar: ----")

    IO.inspect(state)

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

  def print_message_move(player, :heal, life_healed) do
    IO.puts(
      "!!============= #{player} heal itself to #{life_healed} life points. =============!!"
    )
  end
end
