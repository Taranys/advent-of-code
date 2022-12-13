# frozen_string_literal: true

require "minitest/autorun"

require_relative "../helper"
require_relative "../../../lib/advent_of_code_22/day13"

module AdventOfCode22
  module Day13
    EXAMPLE = %([1,1,3,1,1]
[1,1,5,1,1]

[[1],[2,3,4]]
[[1],4]

[9]
[[8,7,6]]

[[4,4],4,4]
[[4,4],4,4,4]

[7,7,7,7]
[7,7,7]

[]
[3]

[[[]]]
[[]]

[1,[2,[3,[4,[5,6,7]]]],8,9]
[1,[2,[3,[4,[5,6,0]]]],8,9])

    class Test < Minitest::Test
      def test_unit
        assert_equal :valid, Compare.pair([1], [2])
        assert_equal :continue, Compare.pair([2], [2])
        assert_equal :invalid, Compare.pair([3], [2])

        assert_equal :valid, Compare.pair([2], [3, 1])
        assert_equal :invalid, Compare.pair([2], [1, 1])

        assert_equal :valid, Compare.pair([2, 4], [3, 2])
        assert_equal :invalid, Compare.pair([3, 4], [3, 2])

        assert_equal :invalid, Compare.pair([7,7,7,7], [7,7,7])
      end

      def test_example
        pairs = Parser.pair(EXAMPLE)
        result = []
        pairs.each_with_index do |p, i|
          result << i+1 if p == :valid
        end
        assert_equal [1, 2, 4, 6], result
      end

      def test_first_star
        pairs = Parser.pair(AdventOfCode22::Helper.load_raw(13))
        sum = 0
        pairs.each_with_index { |p, i| sum += i+1 if p == :valid }
        assert_equal 4734, sum
      end

      # def test_second_example
      #   rd = RopeDimension.new(10)
      #   Parser.rope_movements(EXAMPLE2).each { |move| rd.apply(move) }
      #   assert_equal 36, rd.visited.flatten.sum
      # end
      #
      # def test_second_star
      #   input = AdventOfCode22::Helper.load_input(9)
      #   rd = RopeDimension.new(10)
      #   Parser.rope_movements(input).each { |move| rd.apply(move) }
      #   assert_equal 2678, rd.visited.flatten.sum
      # end
    end
  end
end
