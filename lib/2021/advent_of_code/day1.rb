# frozen_string_literal: true

module AdventOfCode
  # Day 1 of the advent of code 2021
  class Day1
    def self.simple_measure(input)
      input
        .map.with_index { |v, i| i.zero? || input[i - 1] > v ? 0 : 1 }
        .sum
    end

    def self.complex_measure(input)
      input
        .map.with_index { |_v, i| i < (input.size - 3) && input[i..i + 2].sum < input[i + 1..i + 3].sum ? 1 : 0 }
        .sum
    end
  end
end
