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
        monkeys = EXAMPLE.map{ |block| Parser.monkey(block) }
        count = 0
        20.times do
          count += 1

          max_value = monkeys.map(&:test).reduce(:*)
          # p count
          monkeys.each do |monkey|
            monkey.inspect_item_without_stress_release(max_value).each { |result| monkeys[result[:next]].items << result[:item] }
          end
          # p monkeys.map{ |m| m.items }
          # p monkeys.map{ |m| m.inspected_count }
        end
        # p monkeys.map(&:items)
        inspected = monkeys.map(&:inspected_count)
        assert_equal [99, 97, 8, 103], inspected
      end

      def test_second_star
        input = AdventOfCode22::Helper.load_raw(11).split("\n\n").map(&:strip)
        monkeys = input.map{ |block| Parser.monkey(block) }
        count = 0
        10000.times do
          count += 1

          max_value = monkeys.map(&:test).reduce(:*)
          # p count
          monkeys.each do |monkey|
            monkey.inspect_item_without_stress_release(max_value).each { |result| monkeys[result[:next]].items << result[:item] }
          end
          # p monkeys.map{ |m| m.items }
          # p monkeys.map{ |m| m.inspected_count }
        end
        # p monkeys.map(&:items)
        # too low => 8027344865
        inspected = monkeys.map(&:inspected_count).sort.reverse[0..1].reduce(&:*)
        assert_equal 0, inspected
      end
    end
  end
end
