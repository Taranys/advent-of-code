# frozen_string_literal: true

require "matrix"

module AdventOfCode22
  module Day13
    class Parser
      def self.pair(input)
        input.split("\n\n")
          .map do |lines|
            values = lines.split("\n").map { |line| eval(line) }
            Compare.pair(values[0], values[1])
          end
      end
    end

    class Compare
      def self.pair(v1, v2)
        p [v1, v2]
        if v1.is_a?(Integer) && v2.is_a?(Integer)
          return :valid if v1 < v2
          return :invalid if v1 > v2
          return :continue
        end

        return pair([v1], v2) unless v1.is_a?(Array)
        return pair(v1, [v2]) unless v2.is_a?(Array)

        v1.size.times do |i|
          return :invalid if v2[i].nil?

          result = pair(v1[i], v2[i])
          return :valid if result == :valid
          return :invalid if result == :invalid
        end

        v1.size == v2.size ? :continue : :valid
      end

      def value(v1, v2)
        return :valid if v1 < v2
        return :invalid if v1 > v2
        :continue
      end
    end

    class Pair
      def initialize(first, second)
        @first = first
        @second = second
      end

      def valid?
        @first.size.times do |index|
          v1 = @first[index]
          v2 = @second[index]

          p [v1, v2]

          next if v1.nil?
          return false if v1.is_a?(Integer) && v2.nil?
          return false if v1.is_a?(Array) && v2.nil?

          if v1.is_a?(Integer) && v2.is_a?(Integer)
            return false if v1 > v2
            return true if v1 < v2
            next
          end

          if v1.is_a?(Array) && v2.is_a?(Array)
            return false unless Pair.new(v1, v2).valid?
          end

          if !v1.is_a?(Array) && v2.is_a?(Array)
            return false unless Pair.new([v1], [v2.first]).valid?
          end

          if v1.is_a?(Array) && !v2.is_a?(Array)
            return false unless Pair.new([v1.first], [v2]).valid?
          end

          # p [v1, v2]
        end

        true
      end
    end
  end
end
