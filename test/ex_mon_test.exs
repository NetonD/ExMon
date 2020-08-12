defmodule ExMonTest do
  use ExUnit.Case
  import ExUnit.CaptureIO
  alias ExMon.Player
  doctest ExMon.Player

  describe "create_player/4" do
    test "create a new player" do
      player = ExMon.create_player("Neto", :soco, :cura, :chute)

      expected_result = %Player{
        life: 100,
        moves: %{move_heal: :cura, move_random: :chute, move_strong: :soco},
        name: "Neto"
      }

      assert player == expected_result
    end
  end

  describe "start_game/1" do
    test "start an new game with with new player" do
      player = ExMon.create_player("Neto", :soco, :cura, :chute)

      message = capture_io(fn -> ExMon.start_game(player) end)

      assert message =~ "GAME's STARTED"
      assert message =~ "turn: :player"
      assert message =~ "status: :started"
    end
  end

  describe "make_move/1" do
    setup do
      player = ExMon.create_player("Neto", :soco, :cura, :chute)
      message =
        capture_io(fn ->
          ExMon.start_game(player)
        end)

      :ok
    end

    test "when move is valid return turn change message" do
      message =
        capture_io(fn ->
          ExMon.make_move(:chute)
        end)

      assert message =~ "Turn change <!!> now is computer"
      assert message =~ "Turn change <!!> now is computer"
    end

    test "when move is invalid return error message" do
      message =
        capture_io(fn ->
          ExMon.make_move(:machado)
        end)

        assert message =~ "Invalid movement key."
    end
  end
end
