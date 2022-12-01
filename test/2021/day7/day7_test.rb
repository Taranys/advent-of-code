# frozen_string_literal: true

require "minitest/autorun"

require_relative "../helper"
require_relative "../../../lib/advent_of_code/day7"

module AdventOfCode
  class Day7Test < Minitest::Test
    EXAMPLE = %(
    16,1,2,0,4,2,7,1,2,14
).split("\n").map(&:strip).reject(&:empty?)

    def test_example
      assert_equal 37, Day7.align_crabs(EXAMPLE.first.split(",").map(&:to_i), :simple)
      assert_equal 168, Day7.align_crabs(EXAMPLE.first.split(",").map(&:to_i), :complex)
    end

    def test_final
      assert_equal 352_997, Day7.align_crabs(Helper.load_input(7).first.split(",").map(&:to_i), :simple)
      assert_equal 101_571_302, Day7.align_crabs(Helper.load_input(7).first.split(",").map(&:to_i), :complex)
    end
  end
end
