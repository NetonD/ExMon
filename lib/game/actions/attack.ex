defmodule ExMon.Game.Actions.Attack do
  alias ExMon.Game
  alias ExMon.Game.Status
  @move_rnd_power 10..35
  @move_str_power 18..26

  def attack_opponent(opponent, move) do
    damage = evaluate_power(move)

    opponent
    |> Game.fetch_player()
    |> Map.get(:life)
    |> calculate_life_afteer_damage(damage)
    |> update_life_opponent(opponent, damage)
  end

  defp evaluate_power(:move_random), do: Enum.random(@move_rnd_power)
  defp evaluate_power(:move_strong), do: Enum.random(@move_str_power)

  defp calculate_life_afteer_damage(life, damage) when life - damage < 0, do: 0
  defp calculate_life_afteer_damage(life, damage), do: life - damage

  defp update_life_opponent(new_life, opponent, damage) do
    opponent
    |> Game.fetch_player()
    |> Map.put(:life, new_life)
    |> update_game(opponent, damage)
  end

  defp update_game(state, opponent, damage) do
    Game.info()
    |> Map.put(opponent, state)
    |> Game.update()

    Status.print_message_move(opponent, :attack, damage)
  end
end
