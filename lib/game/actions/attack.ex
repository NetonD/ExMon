defmodule ExMon.Game.Actions.Attack do
  alias ExMon.Game
  @move_rnd_power 10..35
  @move_str_power 18..26

  def attack_opponent(opponent, move) do

    damage = evaluate_power(move)

    opponent
    |> Game.fetch_player()
    |> Map.get(:life)
    |> calculate_life_afteer_damage(damage)
    |> update_life_opponent(opponent)
  end

  def evaluate_power(:move_random), do: Enum.random(@move_rnd_power)
  def evaluate_power(:move_strong), do: Enum.random(@move_str_power)

  def calculate_life_afteer_damage(life, damage) when (life - damage) < 0, do: 0
  def calculate_life_afteer_damage(life, damage) , do: life - damage

  def update_life_opponent(new_life, opponent) do
    opponent
    |> Game.fetch_player()
    |> Map.put(:life,new_life)


  end


end
