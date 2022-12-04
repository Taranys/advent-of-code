# frozen_string_literal: true

require "minitest/autorun"

require_relative "../helper"
require_relative "../../../lib/advent_of_code_22/day4"

module AdventOfCode22
  module Day4
    class Test < Minitest::Test
      EXAMPLE = %(
2-4,6-8
2-3,4-5
5-7,7-9
2-8,3-7
6-6,4-6
2-6,4-8
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
