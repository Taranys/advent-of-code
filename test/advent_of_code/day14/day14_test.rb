# frozen_string_literal: true

require "minitest/autorun"

require_relative "../helper"
require_relative "../../../lib/advent_of_code/day14"

module AdventOfCode
  class Day14Test < Minitest::Test
    EXAMPLE = '
NNCB

CH -> B
HH -> N
CB -> H
NH -> C
HB -> C
HC -> B
HN -> C
NN -> C
BH -> H
NC -> B
NB -> B
BN -> B
BB -> N
BC -> B
CC -> N
CN -> C
'.split("\n").map(&:strip).reject(&:empty?).freeze

    def test_part1
      result = Day14.day14(EXAMPLE, 10).values.sort
      assert_equal 1588, result.last - result.first

      result = Day14.day14(Helper.load_input(14), 10).values.sort
      assert_equal 2360, result.last - result.first
    end

    def test_part2
      result = Day14.day14(EXAMPLE, 40).values.sort
      assert_equal 2188189693529, result.last - result.first

      result = Day14.day14(Helper.load_input(14), 40).values.sort
      assert_equal 2967977072188, result.last - result.first
    end
  end
end
