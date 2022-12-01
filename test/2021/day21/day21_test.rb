# frozen_string_literal: true

require "minitest/autorun"

require_relative "../helper"
require_relative "../../../lib/advent_of_code/day21"

module AdventOfCode
  class Day21Test < Minitest::Test
    EXAMPLE = '
'.split("\n").map(&:strip).reject(&:empty?)

    truc = { 3 => 1, 4 => 3, 5 => 6, 6 => 7, 7 => 6, 8 => 3, 9 => 1 }

    def test_dice
      dice = Dice.new
      assert_equal 0, dice.roll_count
      assert_equal 1, dice.roll
      assert_equal 2, dice.roll
      assert_equal 3, dice.roll

      95.times { dice.roll }
      assert_equal 99, dice.roll
      assert_equal 100, dice.roll
      assert_equal 1, dice.roll
      assert_equal 101, dice.roll_count
    end

    def test_part1
      assert_equal 739785, run_game(4, 8)
      assert_equal 900099, run_game(10, 6)
    end

    def test_part2
      values = {}



      #
      # possibilities1 = []
      # possibilities2 = []
      #
      # find_all_possibilities(possibilities1, 10, [])
      # find_all_possibilities(possibilities2, 8, [])
      #
      # p possibilities1
      # p possibilities2
      # p [possibilities1, possibilities2.count, possibilities1.count * possibilities2.count]
    end

    def find_all_possibilities(possibilities, position, paths)
      if score(position, paths) >= 21
        possibilities << paths
        return
      end

      find_all_possibilities(possibilities, position, [*paths, 1])
      find_all_possibilities(possibilities, position, [*paths, 2])
      find_all_possibilities(possibilities, position, [*paths, 3])
    end

    def score(position, paths)
      score = 0
      paths.each do |value|
        position = ((position - 1) + value) % 10 + 1
        score += position
      end
      score
    end

    def run_game(position1 = 0, position2 = 0)
      dice = Dice.new
      player1 = Player.new(position1)
      player2 = Player.new(position2)

      while player1.score < 1000 && player2.score < 1000
        player1.move 3.times.map { dice.roll }.sum
        break if player1.score >= 1000
        player2.move 3.times.map { dice.roll }.sum
      end

      player2.score * dice.roll_count
    end
  end
end
