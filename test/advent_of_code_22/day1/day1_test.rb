# frozen_string_literal: true

require "minitest/autorun"

require_relative "../helper"
require_relative "../../../lib/advent_of_code_22/day1"

module AdventOfCode22
  class Day1Test < Minitest::Test
    def test_first_star
      input = AdventOfCode22::Helper.load_input_raw(1).map(&:to_i)
      assert_equal 69912, AdventOfCode22::Day1.elves(input).first
    end

    def test_second_star
      input = AdventOfCode22::Helper.load_input_raw(1).map(&:to_i)
      assert_equal 208180, AdventOfCode22::Day1.elves(input).take(3).sum
    end
  end
end
