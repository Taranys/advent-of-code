# frozen_string_literal: true

require "minitest/autorun"

require_relative "../helper"
require_relative "../../../lib/advent_of_code/day10"

module AdventOfCode
  class Day10Test < Minitest::Test
    EXAMPLE = '
[({(<(())[]>[[{[]{<()<>>
[(()[<>])]({[<{<<[]>>(
{([(<{}[<>[]}>{[]{[(<()>
(((({<>}<{<{<>}{[]{[]{}
[[<[([]))<([[{}[[()]]]
[{[{({}]{}}([{[{{{}}([]
{<[[]]>}<{[{[{[]{()[[[]
[<(<(<(<{}))><([]([]()
<{([([[(<>()){}]>(<<{{
<{([{{}}[<[[[<>{}]]]>[]]
'.split("\n").map(&:strip).reject(&:empty?)

    EXAMPLE2 = '
[({(<(())[]>[[{[]{<()<>>
[(()[<>])]({[<{<<[]>>(
(((({<>}<{<{<>}{[]{[]{}
{<[[]]>}<{[{[{[]{()[[[]
<{([{{}}[<[[[<>{}]]]>[]]
'.split("\n").map(&:strip).reject(&:empty?)

    def test_simple_case
      assert_equal [")"], illegal_characters(["[)"])
      assert_equal [")]"], auto_complete(["[("])
      assert_equal ["]>}"], auto_complete(["{<[()][()"])
      assert_equal "}}]])})]", auto_complete(EXAMPLE).first
    end

    def test_example
      assert_equal 26_397, illegal_characters(EXAMPLE).map { |char| NavigationSystem::TO_VALUE[char] }.sum

      test = auto_complete(EXAMPLE).map { |v| value(v) }.sort
      assert_equal 288_957, test[test.size / 2]
    end

    def test_final
      navigation_system = NavigationSystem.new(Helper.load_input(10))

      assert_equal 392_043, navigation_system.illegal_characters.map { |char| NavigationSystem::TO_VALUE[char] }.sum

      auto_complete_result = navigation_system.auto_complete.map { |line| value(line) }.sort
      assert_equal 1_605_968_119, auto_complete_result[auto_complete_result.size / 2]
    end

    def value(line)
      sum = 0
      line.chars.map do |c|
        sum *= 5
        sum += 1 if c == ")"
        sum += 2 if c == "]"
        sum += 3 if c == "}"
        sum += 4 if c == ">"
      end
      sum
    end

    def illegal_characters(input)
      NavigationSystem.new(input).illegal_characters
    end

    def auto_complete(input)
      NavigationSystem.new(input).auto_complete
    end
  end
end
