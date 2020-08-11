defmodule ExMon.Game.Actions.Heal do
  @heal_range 12..25

  alias ExMon.Game
  alias ExMon.Game.Status

  def heal_life(player) do
    player
    |> Game.fetch_player()
    |> Map.get(:life)
    |> calculate_heal_value()
    |> set_new_life_value(player)
  end

  def calculate_heal_value(current_life), do: Enum.random(@heal_range) + current_life

  def set_new_life_value(life, player) when life > 100, do: update_state_player(100, player)

  def set_new_life_value(life, player), do: update_state_player(life, player)

  def update_state_player(life, player) do
    player
    |> Game.fetch_player()
    |> Map.put(:life, life)
    |> update_game_state(player, life)
  end

  def update_game_state(player_state, player, life_healed) do
    Game.info()
    |> Map.put(player, player_state)
    |> Game.update()

    Status.print_message_move(player, :heal, life_healed)
  end
end
