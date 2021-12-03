# frozen_string_literal: true

require "minitest/autorun"

require_relative "../helper"
require_relative "../../../lib/advent_of_code/day3"

module AdventOfCode
  class Day3Test < Minitest::Test
    def test_example
      input = %w[00100 11110 10110 10111 10101 01111 00111 11100 10000 11001 00010 01010]

      gamma, epsilon = AdventOfCode::Day3.power_consumption(input)
      assert_equal 22*9, gamma * epsilon
    end

    def test_final
      input = AdventOfCode::Helper.load_input(3)

      gamma, epsilon = AdventOfCode::Day3.power_consumption(input)
      assert_equal 2972336, gamma * epsilon
    end
  end
end
