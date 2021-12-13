# frozen_string_literal: true

require "minitest/autorun"

require_relative "../helper"
require_relative "../../../lib/advent_of_code/day13"

module AdventOfCode
  class Day13Test < Minitest::Test
    EXAMPLE = '
6,10
0,14
9,10
0,3
10,4
4,11
6,0
6,12
4,1
0,13
10,12
3,4
3,0
8,4
1,10
2,14
8,10
9,0

fold along y=7
'.split("\n").map(&:strip).reject(&:empty?)

    def test_part1
      assert_equal 17, ThermalCamera.new(EXAMPLE).visible_dots_after_one_fold

      assert_equal 618, ThermalCamera.new(Helper.load_input(13)).visible_dots_after_one_fold
    end

    RESULT_EXAMPLE = '
# ##  #  #
#   #
      #   #
#   #
 # #  # ###
'[1..-2]

    RESULT_INPUT = '
 ##  #    ###  #### #  # #### #  # #  #
#  # #    #  # #    # #  #    # #  #  #
#  # #    #  # ###  ##   ###  ##   #  #
#### #    ###  #    # #  #    # #  #  #
#  # #    # #  #    # #  #    # #  #  #
#  # #### #  # #### #  # #    #  #  ##
'[1..-2]

    def test_part2
      assert_equal RESULT_EXAMPLE, ThermalCamera.new(EXAMPLE).display_folded_dots

      assert_equal RESULT_INPUT, ThermalCamera.new(Helper.load_input(13)).display_folded_dots
    end
  end
end
