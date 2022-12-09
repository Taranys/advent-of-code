# frozen_string_literal: true

require "minitest/autorun"

require_relative "../helper"
require_relative "../../../lib/advent_of_code_22/day9"

module AdventOfCode22
  module Day9
    EXAMPLE = %(
R 4
U 4
L 3
D 1
R 4
D 1
L 5
R 2
).split("\n").map(&:strip).reject(&:empty?)

    class Test < Minitest::Test
      def test_example
        rd = RopeDimension.new
        Parser.rope_movements(EXAMPLE).each { |move| rd.apply(move) }
        assert_equal 13, rd.visited.flatten.sum
      end

      def test_first_star
        input = AdventOfCode22::Helper.load_input(9)
        rd = RopeDimension.new
        Parser.rope_movements(input).each { |move| rd.apply(move) }
        assert_equal 6486, rd.visited.flatten.sum
      end

      def test_second_example
        assert_equal 8, Parser.trees(EXAMPLE).scenic_score.to_a.flatten.max
      end

      def test_second_star
        input = AdventOfCode22::Helper.load_input(8)
        assert_equal 486_540, Parser.trees(input).scenic_score.to_a.flatten.max
      end
    end
  end
end
