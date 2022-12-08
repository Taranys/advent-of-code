# frozen_string_literal: true

require "minitest/autorun"

require_relative "../helper"
require_relative "../../../lib/advent_of_code_22/day8"

module AdventOfCode22
  module Day8
    EXAMPLE = %(
30373
25512
65332
33549
35390
).split("\n").map(&:strip).reject(&:empty?)

    class Test < Minitest::Test
      def test_example
        p Parser.trees(EXAMPLE).visible_trees
        assert_equal 21, Parser.trees(EXAMPLE).visible_trees
      end

      def test_first_star
        input = AdventOfCode22::Helper.load_input(8)
        assert_equal 21, Parser.trees(input).visible_trees
      end

      def test_second_example
        assert_equal 8, Parser.trees(EXAMPLE).scenic_score.to_a.flatten.max
      end

      def test_second_star
        input = AdventOfCode22::Helper.load_input(8)
        assert_equal 8, Parser.trees(input).scenic_score.to_a.flatten.max
      end
    end
  end
end
