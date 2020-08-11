defmodule ExMon do
  @moves_list [:move_strong, :move_random, :move_heal]

  alias ExMon.{Player, Game}
  alias ExMon.Game.{Status, Actions}

  def create_player(name, strong, heal, random) do
    Player.new(name, strong, heal, random)
  end

  def start_game(player) do
    "Roboto"
    |> create_player(:soco, :cura, :pontape)
    |> Game.start(player)

    Game.info()
    |> Status.print_round_message()
  end

  def make_move(move) do
    Game.info()
    |> handle_status(move)

    Game.info()
    |> computer_move()
  end

  def handle_status(%{status: :game_over} = info, _move), do: Status.print_round_message(info)

  def handle_status(_status, move) do
    move
    |> Actions.fetch_move()
    |> do_move()
  end

  def do_move({:error, move}), do: Status.print_wrong_move(move)

  def do_move({:ok, move}) do
    case move do
      :move_heal -> Actions.heal()
      move -> Actions.attack(move)
    end

    Game.info()
    |> Status.print_round_message()
  end

  defp computer_move(%{turn: :computer, status: :continue}) do
    choice = Enum.random(@moves_list)
    do_move({:ok, choice})
  end

  defp computer_move(_whatever), do: :ok
end
