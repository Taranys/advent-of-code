# frozen_string_literal: true

require "minitest/autorun"

require_relative "../helper"
require_relative "../../../lib/advent_of_code_22/day2"

module AdventOfCode22
  module Day2
    class Test < Minitest::Test
      EXAMPLE = %(
A Y
B X
C Z
).split("\n").map(&:strip).reject(&:empty?)

      def test_each_lines
        assert_equal 8, Tournament.new(["A Y"], TwoShapesParser.new).total_score
        assert_equal 1, Tournament.new(["B X"], TwoShapesParser.new).total_score
        assert_equal 6, Tournament.new(["C Z"], TwoShapesParser.new).total_score
      end

      def test_example
        assert_equal 15, Tournament.new(EXAMPLE, TwoShapesParser.new).total_score
      end

      def test_first_star
        input = AdventOfCode22::Helper.load_input(2)
        assert_equal 11_603, Tournament.new(input, TwoShapesParser.new).total_score
      end

      def test_each_lines_second
        assert_equal 4, Tournament.new(["A Y"], InstructionParser.new).total_score
        assert_equal 1, Tournament.new(["B X"], InstructionParser.new).total_score
        assert_equal 7, Tournament.new(["C Z"], InstructionParser.new).total_score
      end

      def test_second_example
        assert_equal 12, Tournament.new(EXAMPLE, InstructionParser.new).total_score
      end

      def test_second_star
        input = AdventOfCode22::Helper.load_input(2)
        assert_equal 12_725, Tournament.new(input, InstructionParser.new).total_score
      end
    end
  end
end
