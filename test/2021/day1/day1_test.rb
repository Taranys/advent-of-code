# frozen_string_literal: true

require "minitest/autorun"

require_relative "../helper"
require_relative "../../../lib/advent_of_code/day1"

module AdventOfCode
  class Day1Test < Minitest::Test
    def test_no_data
      assert_equal 0, day1_simple([])
      assert_equal 0, day1_complex([])
    end

    def test_one_data
      assert_equal 0, day1_simple([10])
      assert_equal 0, day1_complex([10])
    end

    def test_only_up
      assert_equal 2, day1_simple([1, 2, 3])
      assert_equal 0, day1_complex([1, 2, 3])
    end

    def test_only_down
      assert_equal 0, day1_simple([3, 2, 1])
      assert_equal 0, day1_complex([3, 2, 1])
    end

    def test_mixed
      assert_equal 4, day1_simple([1, 20, 25, 24, 30, 31, 5])
      assert_equal 3, day1_complex([1, 2, 3, 4, 5, 0, 5])
    end

    def test_final
      values = AdventOfCode::Helper.load_input(1).map(&:to_i)

      assert_equal 1215, day1_simple(values)
      assert_equal 1150, day1_complex(values)
    end

    def day1_simple(input)
      AdventOfCode::Day1.simple_measure(input)
    end

    def day1_complex(input)
      AdventOfCode::Day1.complex_measure(input)
    end
  end
end
