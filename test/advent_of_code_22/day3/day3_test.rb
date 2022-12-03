# frozen_string_literal: true

require "minitest/autorun"

require_relative "../helper"
require_relative "../../../lib/advent_of_code_22/day3"

module AdventOfCode22
  module Day3
    class Test < Minitest::Test
      EXAMPLE = %(
vJrwpWtwJgWrhcsFMMfFFhFp
jqHRNqRjqzjGDLGLrsFMfFZSrLrFZsSL
PmmdzqPrVvPwwTWBwg
wMqvLMZHhHMvwLHjbvcjnnSBnvTQFn
ttgJtRGJQctTZtZT
CrZsJsPPZsGzwwsLwLmpwMDw
).split("\n").map(&:strip).reject(&:empty?)

      def day3(input)
        input
          .map do |line|

            s1 = line[0..line.size/2-1]
            s2 = line[line.size/2..-1]
            i = s1.chars.intersection s2.chars
            i.first
        end
          .map{ |c| c == c.upcase ? (c.ord - 'A'.ord) + 27 : (c.ord - 'a'.ord) + 1 }
          .sum

      end

      def test_example
        assert_equal 157, day3(EXAMPLE)
      end

      def test_first_star
        input = AdventOfCode22::Helper.load_input(3)
        assert_equal 7597, day3(input)
      end

      def test_each_lines_second
        assert_equal 4, Tournament.new(["A Y"], InstructionParser.new).total_score
        assert_equal 1, Tournament.new(["B X"], InstructionParser.new).total_score
        assert_equal 7, Tournament.new(["C Z"], InstructionParser.new).total_score
      end

      def test_second_example
        assert_equal 12, Tournament.new(EXAMPLE, InstructionParser.new).total_score
      end

      def test_second_star
        input = AdventOfCode22::Helper.load_input(2)
        assert_equal 12_725, Tournament.new(input, InstructionParser.new).total_score
      end
    end
  end
end
