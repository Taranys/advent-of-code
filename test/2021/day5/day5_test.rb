# frozen_string_literal: true

require "minitest/autorun"

require_relative "../helper"
require_relative "../../../lib/2021/advent_of_code/day5"

module AdventOfCode
  class Day5Test < Minitest::Test
    EXAMPLE = %(
0,9 -> 5,9
8,0 -> 0,8
9,4 -> 3,4
2,2 -> 2,1
7,0 -> 7,4
6,4 -> 2,0
0,9 -> 2,9
3,4 -> 1,4
0,0 -> 8,8
5,5 -> 8,2
).split("\n").map(&:strip).reject(&:empty?)

    def test_line
      assert_equal [[1, 1], [1, 2], [1, 3]], Day5.vents_positions("1,1 -> 1,3")
    end

    def test_column
      assert_equal [[7, 7], [8, 7], [9, 7]], Day5.vents_positions("9,7 -> 7,7")
    end

    def test_diag
      assert_equal [[1, 1], [2, 2], [3, 3]], Day5.vents_positions("1,1 -> 3,3")
      assert_equal [[7, 9], [8, 8], [9, 7]], Day5.vents_positions("9,7 -> 7,9")
    end

    def test_example
      map = Array.new(10) { Array.new(10, 0) }

      fill_map(EXAMPLE, map)

      assert_equal 12, map.flatten.reject { |a| a < 2 }.count
    end

    def test_input
      input = AdventOfCode::Helper.load_input(5)
      map = Array.new(1000) { Array.new(1000, 0) }

      fill_map(input, map)

      assert_equal 18_605, map.flatten.reject { |a| a < 2 }.count
    end

    private

    def fill_map(input, map)
      input
        .map { |line| Day5.vents_positions(line) }
        .flatten(1)
        .each { |p| map[p[1]][p[0]] += 1 }
    end
  end
end
