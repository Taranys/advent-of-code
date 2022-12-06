# frozen_string_literal: true

require "minitest/autorun"

require_relative "../helper"
require_relative "../../../lib/advent_of_code_22/day5"

module AdventOfCode22
  module Day5
    class Test < Minitest::Test
      EXAMPLE = %(
    [D]
[N] [C]
[Z] [M] [P]
 1   2   3

move 1 from 2 to 1
move 3 from 1 to 3
move 2 from 2 to 1
move 1 from 1 to 2
)

      def test_parse_ship
        assert_equal "NDP", Parser.ship(EXAMPLE).top_crates
      end

      def test_example
        ship = Parser.ship(EXAMPLE)
        moves = Parser.moves(EXAMPLE)
        crane = Crane.new(ship)
        moves.each { |move| crane.apply(move) }

        assert_equal "CMZ", ship.top_crates
      end

      def test_first_star
        input = AdventOfCode22::Helper.load_raw(5)
        ship = Parser.ship(input)
        moves = Parser.moves(input)
        crane = Crane.new(ship)
        moves.each { |move| crane.apply(move) }

        assert_equal "RLFNRTNFB", ship.top_crates
      end

      def test_second_example
        ship = Parser.ship(EXAMPLE)
        moves = Parser.moves(EXAMPLE)
        crane = Crane9001.new(ship)
        moves.each { |move| crane.apply(move) }

        assert_equal "MCD", ship.top_crates
      end

      def test_second_star
        input = AdventOfCode22::Helper.load_raw(5)
        ship = Parser.ship(input)
        moves = Parser.moves(input)
        crane = Crane9001.new(ship)
        moves.each { |move| crane.apply(move) }

        assert_equal "MHQTLJRLB", ship.top_crates
      end
    end
  end
end
