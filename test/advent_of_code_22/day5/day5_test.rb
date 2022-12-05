# frozen_string_literal: true

require "minitest/autorun"

require_relative "../helper"
require_relative "../../../lib/advent_of_code_22/day4"

module AdventOfCode22
  module Day4
    class Test < Minitest::Test
      EXAMPLE = %(
    [D]
[N] [C]
[Z] [M] [P]
 1   2   3

move 1 from 2 to 1
move 3 from 1 to 3
move 2 from 2 to 1
move 1 from 1 to 2
).split("\n").map(&:strip).reject(&:empty?)

      def test_example
        assert_equal 2, Parser.section_assignments(EXAMPLE).count(&:fully_overlapse?)
      end

      def test_first_star
        input = AdventOfCode22::Helper.load_input(4)
        assert_equal 657, Parser.section_assignments(input).count(&:fully_overlapse?)
      end

      def test_second_example
        assert_equal 4, Parser.section_assignments(EXAMPLE).count(&:overlapse?)
      end

      def test_second_star
        input = AdventOfCode22::Helper.load_input(4)
        assert_equal 938, Parser.section_assignments(input).count(&:overlapse?)
      end
    end
  end
end
