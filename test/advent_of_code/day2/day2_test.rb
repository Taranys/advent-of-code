# frozen_string_literal: true

require "minitest/autorun"

require_relative "../helper"
require_relative "../../../lib/advent_of_code/day2"

module AdventOfCode
  class Day2Test < Minitest::Test
    def test_no_data
      assert_equal 0, create_submarine.move([]).horizontal
    end

    def test_forward
      assert_equal 10, create_submarine.move(["forward 10"]).horizontal
    end

    def test_down
      assert_equal 10, create_submarine.move(["down 10"]).depth
    end

    def test_up
      assert_equal 5, create_submarine.move(["down 8", "up 3"]).depth
    end

    def test_final
      submarine = create_submarine.move(AdventOfCode::Helper.loadInput(2))

      assert_equal 1561344, submarine.depth * submarine.horizontal
    end

    def create_submarine
      AdventOfCode::Day2.new
    end
  end
end
