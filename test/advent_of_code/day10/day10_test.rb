# frozen_string_literal: true

require "minitest/autorun"

require_relative "../helper"
require_relative "../../../lib/advent_of_code/day10"

module AdventOfCode
  class Day10Test < Minitest::Test
    EXAMPLE = """
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
""".split("\n").map(&:strip).reject(&:empty?)

    EXAMPLE2 = """
[({(<(())[]>[[{[]{<()<>>
[(()[<>])]({[<{<<[]>>(
(((({<>}<{<{<>}{[]{[]{}
{<[[]]>}<{[{[{[]{()[[[]
<{([{{}}[<[[[<>{}]]]>[]]
""".split("\n").map(&:strip).reject(&:empty?)

    def test_example
      assert_equal [")"], illegal_characters(["[)"])
      assert_equal 26397, illegal_characters(EXAMPLE).map { |char| NavigationSystem.char_to_i(char) }.sum

      assert_equal [")]"], auto_complete(["[("])
      assert_equal ["]>}"], auto_complete(["{<[()][()"])
      assert_equal "}}]])})]", auto_complete(EXAMPLE).first

      test = auto_complete(EXAMPLE).map { |v| value(v) }.sort
      p test
      assert_equal 288957, test[test.size / 2]

      # assert 1134, basin.basins.sort { |a, b| a <=> b }.take(3).inject(:*)
    end

    def test_final
      navigation_system = NavigationSystem.new(Helper.load_input(10))
      assert_equal 392043, navigation_system.illegal_characters.map { |char| NavigationSystem.char_to_i(char) }.sum
      test = navigation_system.auto_complete.map { |line| value(line) }.sort
      assert_equal 1605968119, test[test.size / 2]

      # assert_equal 736_920, basin.basins.sort { |a, b| -(a <=> b) }.take(3).inject(:*)
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
