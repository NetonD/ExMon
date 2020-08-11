defmodule ExMon.GameTest do
  use ExUnit.Case

  alias ExMon.{Game, Player}

  describe "start/2" do
    test "start a new game with two players" do
      player = Player.new("Neto", :soco, :cura, :chute)
      computer = Player.new("Roboto", :soco, :cura, :chute)

      response = Game.start(computer, player)

      assert {:ok, _PID} = response
    end
  end

  describe "info/0" do
    test "return a state info about game" do
      player = Player.new("Neto", :soco, :cura, :chute)
      computer = Player.new("Roboto", :soco, :cura, :chute)
      Game.start(computer, player)

      response = Game.info()

      expected_response = %{
        computer: %Player{
          life: 100,
          moves: %{move_heal: :cura, move_random: :chute, move_strong: :soco},
          name: "Roboto"
        },
        player: %Player{
          life: 100,
          moves: %{move_heal: :cura, move_random: :chute, move_strong: :soco},
          name: "Neto"
        },
        status: :started,
        turn: :player
      }

      assert response == expected_response
    end
  end

  describe "update/1" do
    test "update must change state game" do
      player = Player.new("Neto", :soco, :cura, :chute)
      computer = Player.new("Roboto", :soco, :cura, :chute)
      Game.start(computer, player)

      response = Game.info()

      expected_response = %{
        computer: %Player{
          life: 100,
          moves: %{move_heal: :cura, move_random: :chute, move_strong: :soco},
          name: "Roboto"
        },
        player: %Player{
          life: 100,
          moves: %{move_heal: :cura, move_random: :chute, move_strong: :soco},
          name: "Neto"
        },
        status: :started,
        turn: :player
      }

      assert response == expected_response

      new_state = %{
        computer: %Player{
          life: 100,
          moves: %{move_heal: :cura, move_random: :chute, move_strong: :soco},
          name: "Roboto"
        },
        player: %Player{
          life: 100,
          moves: %{move_heal: :cura, move_random: :chute, move_strong: :soco},
          name: "Neto"
        },
        status: :started,
        turn: :player
      }

      Game.update(new_state)
      expected_response = %{new_state | status: :continue, turn: :computer}

      assert expected_response == Game.info()
    end
  end

  describe "player/0" do
    test "get status of player" do
      player = Player.new("Neto", :soco, :cura, :chute)
      computer = Player.new("Roboto", :soco, :cura, :chute)
      Game.start(computer, player)

      player_info = Game.player()

      expected_response = %Player{
        life: 100,
        moves: %{move_heal: :cura, move_random: :chute, move_strong: :soco},
        name: "Neto"
      }

      assert player_info == expected_response
    end
  end

  describe "turn/0" do
    test "return what is current turn" do
      player = Player.new("Neto", :soco, :cura, :chute)
      computer = Player.new("Roboto", :soco, :cura, :chute)
      Game.start(computer, player)

      current_turn = Game.turn()

      assert current_turn == :player
    end
  end

  describe "fetch_player/0" do
    test "returns information of player or computer similar to player/0" do
      player = Player.new("Neto", :soco, :cura, :chute)
      computer = Player.new("Roboto", :soco, :cura, :chute)
      Game.start(computer, player)

      computer_info = Game.fetch_player(:computer)
      player_info = Game.fetch_player(:player)

      expected_computer = %Player{
        life: 100,
        moves: %{move_heal: :cura, move_random: :chute, move_strong: :soco},
        name: "Roboto"
      }

      expected_player = %Player{
        life: 100,
        moves: %{move_heal: :cura, move_random: :chute, move_strong: :soco},
        name: "Neto"
      }

      assert computer_info == expected_computer
      assert player_info == expected_player
    end
  end
end
