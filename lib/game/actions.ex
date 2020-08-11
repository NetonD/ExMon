defmodule ExMon.Game.Actions do
  alias ExMon.Game
  alias ExMon.Game.Actions.Attack
  def fetch_move(move) do
    Game.player()
    |> Map.get(:moves)
    |> find_move(move)
  end

  def find_move(moves_list, move) do
    moves_list
    |>Enum.find_value({:error, move}, fn {key,value} ->
      if value == move, do: {:ok, key}
    end)
  end


  def attack(move) do
    case Game.turn() do
      :player -> Attack.attack_opponent(:computer, move)
      :computer -> Attack.attack_opponent(:player, move)
    end
  end
end
