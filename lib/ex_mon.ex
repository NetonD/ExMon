defmodule ExMon do
  alias ExMon.{Player,Game}
  alias ExMon.Game.{Status,Actions}
  def create_player(name, strong, heal, random) do
    Player.new(name, strong, heal, random)
  end

  def start_game(player) do
    "Roboto"
    |>create_player(:soco,:cura,:piui)
    |>Game.start(player)

    Game.info()
    |>Status.print_round_message()
  end

  def make_move(move) do
    move
    |> Actions.fetch_move()
    |> do_move()
  end

  def do_move({:error, move}), do: Status.print_wrong_move(move)

  def do_move({:ok, move}) do
    case move do
      :move_heal -> "Curando em XPTO"
      move -> Actions.attack(move)
    end

    Game.info()
    |>Status.print_round_message()
  end

end
