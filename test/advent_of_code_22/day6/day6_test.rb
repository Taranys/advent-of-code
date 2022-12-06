# frozen_string_literal: true

require "minitest/autorun"

require_relative "../helper"
require_relative "../../../lib/advent_of_code_22/day6"

module AdventOfCode22
  module Day6
    class Test < Minitest::Test
      def test_example
        input = "mjqjpqmgbljsphdztnvjfqwrcgsmlb"
        assert_equal 7, Parser.distinct_chars_index(input)
      end

      def test_first_star
        input = AdventOfCode22::Helper.load_input(6).first
        assert_equal 1816, Parser.distinct_chars_index(input)
      end

      def test_second_example
        input = "mjqjpqmgbljsphdztnvjfqwrcgsmlb"
        assert_equal 19, Parser.distinct_chars_index(input, 14)
      end

      def test_second_star
        input = AdventOfCode22::Helper.load_input(6).first
        assert_equal 2625, Parser.distinct_chars_index(input, 14)
      end
    end
  end
end
