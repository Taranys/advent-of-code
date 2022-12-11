# frozen_string_literal: true

require "matrix"

module AdventOfCode22
  module Day11

    class Parser
      def self.monkey(block)
        lines = block.split("\n")
        Monkey.new(
          /Monkey (\d+):/.match(lines[0])[1].to_i,
          /Starting items: (.+)$/.match(lines[1])[1].split(',').map(&:strip).map(&:to_i),
          /Operation: new = (.+)$/.match(lines[2])[1],
          /Test: divisible by (\d+)/.match(lines[3])[1].to_i,
          /If true: throw to monkey (\d+)/.match(lines[4])[1].to_i,
          /If false: throw to monkey (\d+)/.match(lines[5])[1].to_i,
        )
      end
    end

    class Monkey
      attr_accessor :items, :inspected_count, :test

      def initialize(index, items, operation, test, true_monkey, false_monkey)
        @index = index
        @items = items
        @operation = operation.split(' ')
        @test = test
        @true_monkey = true_monkey
        @false_monkey = false_monkey
        @inspected_count = 0
      end

      def inspect_item
        @inspected_count += @items.count

        result = @items.map do |item|
          new_value = (new_item_value(item) / 3).to_i
          if new_value % @test == 0
            { next: @true_monkey, item: new_value }
          else
            { next: @false_monkey, item: new_value }
          end
        end
        @items = []
        result
      end

      def inspect_item_without_stress_release(max_value)
        @inspected_count += @items.count

        result = @items.map do |item|
          new_value = new_item_value(item)
          new_value = new_value % max_value

          if new_value % @test == 0
            { next: @true_monkey, item: new_value }
          else
            { next: @false_monkey, item: new_value }
          end
        end
        @items = []
        result
      end

      def new_item_value(value)
        a, op, b = @operation
        a = value if a == 'old'
        b = value if b == 'old'
        a.to_i.send(op.to_sym, b.to_i)
      end
    end
  end
end
