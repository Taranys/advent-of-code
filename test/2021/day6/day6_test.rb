# frozen_string_literal: true

require "minitest/autorun"

require_relative "../helper"
require_relative "../../../lib/2021/advent_of_code/day6"

module AdventOfCode
  class Day6Test < Minitest::Test
    EXAMPLE = %(
).split("\n").map(&:strip).reject(&:empty?)

    def test_example
      population = LanternFishPopulation.new([3, 4, 3, 1, 2])

      18.times { population.next_day }
      assert_equal 26, population.count

      (256 - 18).times { population.next_day }
      assert_equal 26_984_457_539, population.count
    end

    def test_final
      input = Helper.load_input(6).first.split(",").map(&:to_i)

      population = LanternFishPopulation.new(input)

      18.times { population.next_day }
      assert_equal 1670, population.count

      (256 - 18).times { population.next_day }
      assert_equal 1_653_250_886_439, population.count
    end
  end
end
