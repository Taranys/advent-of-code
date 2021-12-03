# frozen_string_literal: true

require "minitest/autorun"

require_relative "../helper"
require_relative "../../../lib/advent_of_code/day3"

module AdventOfCode
  class Day3Test < Minitest::Test
    def test_example
      input = %w[00100 11110 10110 10111 10101 01111 00111 11100 10000 11001 00010 01010]

      gamma, epsilon = AdventOfCode::Day3.power_consumption(normalize_data(input))
      assert_equal 22*9, gamma * epsilon
    end

    def test_final
      input = AdventOfCode::Helper.load_input(3)

      gamma, epsilon = AdventOfCode::Day3.power_consumption(normalize_data(input))
      assert_equal 2972336, gamma * epsilon
    end

    def test_oxygen
      input = %w[00100 11110 10110 10111 10101 01111 00111 11100 10000 11001 00010 01010]

      assert_equal 23, AdventOfCode::Day3.oxygen_generator_support(input)
    end

    def test_c02
      input = %w[00100 11110 10110 10111 10101 01111 00111 11100 10000 11001 00010 01010]

      assert_equal 10, AdventOfCode::Day3.c02(input)
    end

    def test_final2
      input = AdventOfCode::Helper.load_input(3).map(&:strip)

      assert_equal 3368358, AdventOfCode::Day3.oxygen_generator_support(input) * AdventOfCode::Day3.c02(input)
    end

    def normalize_data(input)
      input.map(&:strip).map { |entry| entry.each_char.map(&:to_i) }
    end
  end
end
