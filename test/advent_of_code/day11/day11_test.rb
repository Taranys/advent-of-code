# frozen_string_literal: true

require "minitest/autorun"

require_relative "../helper"
require_relative "../../../lib/advent_of_code/day11"

module AdventOfCode
  class Day11Test < Minitest::Test
    EXAMPLE = """
5483143223
2745854711
5264556173
6141336146
6357385478
4167524645
2176841721
6882881134
4846848554
5283751526
""".split("\n").map(&:strip).reject(&:empty?)

    def test_example
      assert_equal 1656, Cave.new(EXAMPLE).steps(100).octopuses.map(&:flash_count).sum
      assert_equal 195, Cave.new(EXAMPLE).synchronized_step
    end

    def test_final
      assert_equal 1713, Cave.new(Helper.load_input(11)).steps(100).octopuses.map(&:flash_count).sum
      assert_equal 502, Cave.new(Helper.load_input(11)).synchronized_step
    end
  end
end
