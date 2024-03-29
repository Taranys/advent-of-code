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

      def intersect_line(line)
        s1 = line[0..line.size / 2 - 1]
        s2 = line[line.size / 2..]
        i = s1.chars.intersection s2.chars
        i.first
      end

      def day3(input)
        input
          .map { |line| intersect_line(line) }
          .map { |c| c == c.upcase ? (c.ord - "A".ord) + 27 : (c.ord - "a".ord) + 1 }
          .sum
      end

      def test_example
        assert_equal 157, day3(EXAMPLE)
      end

      def test_first_star
        input = AdventOfCode22::Helper.load_input(3)
        assert_equal 7597, day3(input)
      end

      def intersect_lines(lines)
        l1, l2, l3 = lines
        i = l1.chars.intersection(l2.chars).intersection(l3.chars)
        i.first
      end

      def day3_second_star(input)
        input
          .each_slice(3)
          .to_a
          .map { |lines| intersect_lines(lines) }
          .map { |c| c == c.upcase ? (c.ord - "A".ord) + 27 : (c.ord - "a".ord) + 1 }
          .sum
      end

      def test_second_example
        assert_equal 70, day3_second_star(EXAMPLE)
      end

      def test_second_star
        input = AdventOfCode22::Helper.load_input(3)
        assert_equal 2607, day3_second_star(input)
      end
    end
  end
end
