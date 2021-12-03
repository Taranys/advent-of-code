# frozen_string_literal: true

module AdventOfCode
  # Day 3
  class Day3
    def self.power_consumption(input)
      gamma = input.map(&:strip)
          .map { |entry| entry.each_char.map(&:to_i) }
         .transpose
         .map { |values| values.count(0) }
         .map { |number_of_0| number_of_0 >= (input.count / 2) ? 0 : 1 }
         .join

      [gamma.to_i(2), gamma.chars.map{ |v| v == '0' ? '1' : '0' }.join.to_i(2)]
    end
  end
end
