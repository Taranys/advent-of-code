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
      assert_equal 15, Day9.new(EXAMPLE).low_points.map { |v| v + 1 }.sum
    end

    def test_final
      input = Helper.load_input(9)
      assert_equal 539, Day9.new(input).low_points.map { |v| v + 1 }.sum
    end
  end
end
