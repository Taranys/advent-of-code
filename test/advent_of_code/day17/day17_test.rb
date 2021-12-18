# frozen_string_literal: true

require "minitest/autorun"

require_relative "../helper"
require_relative "../../../lib/advent_of_code/day17"

module AdventOfCode
  class Day17Test < Minitest::Test
    EXAMPLE = '
    target area: x=20..30, y=-10..-5
'.split("\n").map(&:strip).reject(&:empty?)

    def test_part1
      probe = Probe.new("target area: x=20..30, y=-10..-5")
      assert_equal true, probe.touch_target(7, 2)
      assert_equal true, probe.touch_target(6, 3)
      assert_equal true, probe.touch_target(9, 0)
      assert_equal false, probe.touch_target(17, -4)
      assert_equal true, probe.touch_target(6, 1)

      assert_equal 45, Probe.new("target area: x=20..30, y=-10..-5").max_y
      assert_equal 33670, Probe.new(Helper.load_input(17).first).max_y
    end

    def test_part2
    end
  end
end
