# frozen_string_literal: true

require "minitest/autorun"

require_relative "../helper"
require_relative "../../../lib/2021/advent_of_code/day2"

module AdventOfCode
  class Day2Test < Minitest::Test
    def test_no_data
      assert_equal 0, create_submarine.move([]).horizontal

      assert_equal 0, create_submarine.move_with_aim([]).horizontal
    end

    def test_forward
      assert_equal 10, create_submarine.move(["forward 10"]).horizontal

      assert_equal 5, create_submarine.move_with_aim(["forward 5"]).horizontal
    end

    def test_down
      assert_equal 10, create_submarine.move(["down 10"]).depth

      submarine = create_submarine.move_with_aim(["down 5"])
      assert_equal 0, submarine.depth
      assert_equal 5, submarine.aim
    end

    def test_up
      assert_equal 5, create_submarine.move(["down 8", "up 3"]).depth

      submarine = create_submarine.move_with_aim(["down 12", "up 3"])
      assert_equal 0, submarine.depth
      assert_equal 9, submarine.aim
    end

    def test_forward_with_aim
      submarine = create_submarine.move_with_aim(["down 2", "forward 5"])
      assert_equal 5, submarine.horizontal
      assert_equal 2, submarine.aim
      assert_equal 10, submarine.depth
    end

    def test_example
      submarine = create_submarine.move_with_aim(["forward 5", "down 5", "forward 8", "up 3", "down 8", "forward 2"])
      assert_equal 15, submarine.horizontal
      assert_equal 10, submarine.aim
      assert_equal 60, submarine.depth
    end

    def test_final
      submarine = create_submarine.move(AdventOfCode::Helper.load_input(2))

      assert_equal 1_561_344, submarine.depth * submarine.horizontal
    end

    def test_final_with_aim
      submarine = create_submarine.move_with_aim(AdventOfCode::Helper.load_input(2))

      assert_equal 1_848_454_425, submarine.depth * submarine.horizontal
    end

    def create_submarine
      AdventOfCode::Day2.new
    end
  end
end
