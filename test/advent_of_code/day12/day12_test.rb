# frozen_string_literal: true

require "minitest/autorun"

require_relative "../helper"
require_relative "../../../lib/advent_of_code/day12"

module AdventOfCode
  class Day12Test < Minitest::Test
    EXAMPLE = """
start-A
start-b
A-b
A-c
b-d
A-end
b-end
""".split("\n").map(&:strip).reject(&:empty?)

    def test_example
      assert_equal 10, GPS.new(EXAMPLE).go_to_end.size
      assert_equal 36, GPS.new(EXAMPLE).go_to_end_twice.size
    end

    def test_final
      assert_equal 5104, GPS.new(Helper.load_input(12)).go_to_end.size
      assert_equal 149220, GPS.new(Helper.load_input(12)).go_to_end_twice.size
    end
  end
end
