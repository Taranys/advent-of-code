# frozen_string_literal: true

require "minitest/autorun"

require_relative "../helper"
require_relative "../../../lib/advent_of_code_22/day11"

module AdventOfCode22
  module Day11
    EXAMPLE = %(
Monkey 0:
  Starting items: 79, 98
  Operation: new = old * 19
  Test: divisible by 23
    If true: throw to monkey 2
    If false: throw to monkey 3

Monkey 1:
  Starting items: 54, 65, 75, 74
  Operation: new = old + 6
  Test: divisible by 19
    If true: throw to monkey 2
    If false: throw to monkey 0

Monkey 2:
  Starting items: 79, 60, 97
  Operation: new = old * old
  Test: divisible by 13
    If true: throw to monkey 1
    If false: throw to monkey 3

Monkey 3:
  Starting items: 74
  Operation: new = old + 3
  Test: divisible by 17
    If true: throw to monkey 0
    If false: throw to monkey 1
).split("\n\n").map(&:strip)

    class Test < Minitest::Test
      def test_example
        monkeys = EXAMPLE.map{ |block| Parser.monkey(block) }
        20.times do
          monkeys.each do |monkey|
            monkey.inspect_item.each { |result| monkeys[result[:next]].items << result[:item] }
          end
        end
        inspected = monkeys.map(&:inspected_count).sort.reverse
        assert_equal 10605, inspected[0] * inspected[1]
      end

      def test_first_star
        input = AdventOfCode22::Helper.load_raw(11).split("\n\n").map(&:strip)
        monkeys = input.map{ |block| Parser.monkey(block) }
        20.times do
          monkeys.each do |monkey|
            monkey.inspect_item.each { |result| monkeys[result[:next]].items << result[:item] }
          end
        end
        inspected = monkeys.map(&:inspected_count).sort.reverse
        assert_equal 50616, inspected[0] * inspected[1]
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
