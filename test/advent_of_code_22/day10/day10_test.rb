# frozen_string_literal: true

require "minitest/autorun"

require_relative "../helper"
require_relative "../../../lib/advent_of_code_22/day10"

module AdventOfCode22
  module Day10
    EXAMPLE = %(
addx 15
addx -11
addx 6
addx -3
addx 5
addx -1
addx -8
addx 13
addx 4
noop
addx -1
addx 5
addx -1
addx 5
addx -1
addx 5
addx -1
addx 5
addx -1
addx -35
addx 1
addx 24
addx -19
addx 1
addx 16
addx -11
noop
noop
addx 21
addx -15
noop
noop
addx -3
addx 9
addx 1
addx -3
addx 8
addx 1
addx 5
noop
noop
noop
noop
noop
addx -36
noop
addx 1
addx 7
noop
noop
noop
addx 2
addx 6
noop
noop
noop
noop
noop
addx 1
noop
noop
addx 7
addx 1
noop
addx -13
addx 13
addx 7
noop
addx 1
addx -33
noop
noop
noop
addx 2
noop
noop
noop
addx 8
noop
addx -1
addx 2
addx 1
noop
addx 17
addx -9
addx 1
addx 1
addx -3
addx 11
noop
noop
addx 1
noop
addx 1
noop
noop
addx -13
addx -19
addx 1
addx 3
addx 26
addx -30
addx 12
addx -1
addx 3
addx 1
noop
noop
noop
addx -9
addx 18
addx 1
addx 2
noop
noop
addx 9
noop
noop
noop
addx -1
addx 2
addx -37
addx 1
addx 3
noop
addx 15
addx -21
addx 22
addx -6
addx 1
noop
addx 2
addx 1
noop
addx -10
noop
noop
addx 20
addx 1
addx 2
addx 2
addx -6
addx -11
noop
noop
noop
).split("\n").map(&:strip).reject(&:empty?)

    class Test < Minitest::Test
      def test_example
        signal = Parser.signal(EXAMPLE)
        p signal
        i = 20
        count = 0
        while i < signal.size do
          p [i, signal[i-1]]
          count += (i * signal[i-1])
          i += 40
        end
        assert_equal 13140, count
      end

      def test_first_star
        input = AdventOfCode22::Helper.load_input(10)
        signal = Parser.signal(input)
        p signal
        i = 20
        count = 0
        while i < signal.size do
          p [i, signal[i-1]]
          count += (i * signal[i-1])
          i += 40
        end
        assert_equal 13140, count
      end

      def test_second_example
        rd = RopeDimension.new(10)
        Parser.rope_movements(EXAMPLE2).each { |move| rd.apply(move) }
        assert_equal 36, rd.visited.flatten.sum
      end

      def test_second_star
        input = AdventOfCode22::Helper.load_input(9)
        rd = RopeDimension.new(10)
        Parser.rope_movements(input).each { |move| rd.apply(move) }
        assert_equal 2678, rd.visited.flatten.sum
      end
    end
  end
end
