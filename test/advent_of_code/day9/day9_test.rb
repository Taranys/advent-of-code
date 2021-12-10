# frozen_string_literal: true

require "minitest/autorun"

require_relative "../helper"
require_relative "../../../lib/advent_of_code/day9"

module AdventOfCode
  class Day9Test < Minitest::Test
    EXAMPLE = %(
2199943210
3987894921
9856789892
8767896789
9899965678
).split("\n").map(&:strip).reject(&:empty?)
    def test_example
      basin = SmokeBasin.new(EXAMPLE)
      assert 15, basin.low_points.map(&:risk_level).sum
      assert 1134, basin.basins.sort { |a, b| a <=> b }.take(3).inject(:*)
    end

    def test_final
      basin = SmokeBasin.new(Helper.load_input(9))
      assert_equal 539, basin.low_points.map(&:risk_level).sum
      assert_equal 736_920, basin.basins.sort { |a, b| a <=> b }.take(3).inject(:*)
    end
  end
end
