# frozen_string_literal: true

require "minitest/autorun"

require_relative "../helper"
require_relative "../../../lib/advent_of_code_22/day14"

module AdventOfCode22
  module Day14
    EXAMPLE = %(
498,4 -> 498,6 -> 496,6
503,4 -> 502,4 -> 502,9 -> 494,9
).split("\n").map(&:strip).reject(&:empty?)

    INPUT = AdventOfCode22::Helper.load_input(14)

    class Test < Minitest::Test
      def test_example
        cave = Parser.cave(EXAMPLE)
        count = 0
        count += 1 while cave.drop_sand
        # cave.print
        assert_equal 24, count
      end

      def test_first_star
        cave = Parser.cave(INPUT)
        count = 0
        count += 1 while cave.drop_sand
        # cave.print
        assert_equal 799, count
      end

      def test_second_example
        cave = Parser.cave(EXAMPLE, with_floor: true)
        count = 0
        count += 1 while cave.drop_sand
        # cave.print
        assert_equal 93, count
      end

      def test_second_star
        cave = Parser.cave(INPUT, with_floor: true)
        count = 0
        count += 1 while cave.drop_sand
        # cave.print
        assert_equal 29_076, count
      end
    end
  end
end
