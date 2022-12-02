# frozen_string_literal: true

require "minitest/autorun"

require_relative "../helper"
require_relative "../../../lib/advent_of_code_22/day2"

module AdventOfCode22
  class Day2Test < Minitest::Test
    EXAMPLE = %(
A Y
B X
C Z
).split("\n").map(&:strip).reject(&:empty?)

    def test_each_lines
      assert_equal 8, AdventOfCode22::Day2.compute_score(["A Y"])
      assert_equal 1, AdventOfCode22::Day2.compute_score(["B X"])
      assert_equal 6, AdventOfCode22::Day2.compute_score(["C Z"])
    end

    def test_example
      assert_equal 15, AdventOfCode22::Day2.compute_score(EXAMPLE)
    end

    def test_first_star
      input = AdventOfCode22::Helper.load_input(2)
      assert_equal 11_603, AdventOfCode22::Day2.compute_score(input)
    end

    def test_each_lines_second
      assert_equal 4, AdventOfCode22::Day2.compute_score(["A Y"], advanced: true)
      assert_equal 1, AdventOfCode22::Day2.compute_score(["B X"], advanced: true)
      assert_equal 7, AdventOfCode22::Day2.compute_score(["C Z"], advanced: true)
    end

    def test_second_star
      input = AdventOfCode22::Helper.load_input(2)
      assert_equal 12_725, AdventOfCode22::Day2.compute_score(input, advanced: true)
    end
  end
end