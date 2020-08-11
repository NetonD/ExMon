defmodule ExMon.Player do
  @moduledoc """
  This module define a struct to describe a player data type.
  """

  @max_life 100
  @required_keys [:name, :life, :moves]

  @enforce_keys @required_keys
  defstruct @required_keys

  @doc """
  Build a new player struct with parameters

  ## Examples
      iex> ExMon.Player.new("neto","voadora","tapioca","girapomba")
      %ExMon.Player{
        life: 100,
        moves: %{
          move_heal: "tapioca",
          move_random: "girapomba",
          move_strong: "voadora",
        },
        name: "neto"
      }
  """
  def new(name, strong, heal, random) do
    %ExMon.Player{
      life: @max_life,
      moves: %{
        move_strong: strong,
        move_heal: heal,
        move_random: random
      },
      name: name
    }
  end
end
