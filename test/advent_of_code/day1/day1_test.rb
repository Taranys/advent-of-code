require 'minitest/autorun'

require_relative '../../../lib/advent_of_code/day1/day1'

module AdventOfCode
  class Day1Test < Minitest::Test

    def test_no_data
      assert_equal 0, day1([])
      assert_equal 0, day1_bis([])
    end

    def test_one_data
      assert_equal 0, day1([10])
      assert_equal 0, day1_bis([10])
    end

    def test_only_up
      assert_equal 2, day1([1, 2, 3])
      assert_equal 0, day1_bis([1, 2, 3])
    end

    def test_only_down
      assert_equal 0, day1([3, 2, 1])
      assert_equal 0, day1_bis([3, 2, 1])
    end

    def test_mixed
      assert_equal 4, day1([1, 20, 25, 24, 30, 31, 5])
      assert_equal 3, day1_bis([1, 2, 3, 4, 5, 0, 5])
    end

    def test_final
      lines = File.open('/Users/yoann.prot/dev/advent-of-code-2021/test/advent_of_code/day1/input.txt').readlines

      assert_equal 1215, day1(lines.map{|v| v.to_i})
      assert_equal 1215, day1_bis(lines.map{|v| v.to_i})
    end

    def day1(input)
      AdventOfCode::Day1.simple_measure(input)
    end

    def day1_bis(input)
      AdventOfCode::Day1.complex_measure(input)
    end

  end
end