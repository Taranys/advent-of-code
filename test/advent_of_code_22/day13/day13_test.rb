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

      def find_index(ordered_result, v)
        ordered_result.size.times do |i|
          if Compare.pair(v, ordered_result[i]) == :valid
            return i
          end
        end
      end

      def test_second_example
        pairs = Parser.entries(EXAMPLE)
        pairs << [[2]]
        pairs << [[6]]

        ordered_result = []
        pairs.each do |v|
          i = find_index(ordered_result, v)
          if i.nil?
            ordered_result << v
          else
            ordered_result.insert(i, v)
          end
        end

        first_divider = ordered_result.find_index { |v| v == [[2]] } + 1
        second_divider = ordered_result.find_index { |v| v == [[6]] } + 1

        assert_equal 140, first_divider * second_divider
      end

      def test_second_star
        pairs = Parser.entries(AdventOfCode22::Helper.load_raw(13))
        pairs << [[2]]
        pairs << [[6]]

        ordered_result = []
        pairs.each do |v|
          i = find_index(ordered_result, v)
          if i.nil?
            ordered_result << v
          else
            ordered_result.insert(i, v)
          end
        end

        first_divider = ordered_result.find_index { |v| v == [[2]] } + 1
        second_divider = ordered_result.find_index { |v| v == [[6]] } + 1

        assert_equal 21836, first_divider * second_divider
      end
    end
  end
end
