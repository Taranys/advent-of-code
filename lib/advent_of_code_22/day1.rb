# frozen_string_literal: true

module AdventOfCode22
  # Day 1 of the advent of code 2021
  class Day1
    def self.parse(input)
      input
        .map(&:to_i)
        .each_with_object([0]) do |calories, values|
        if calories.zero?
          values << 0
        else
          values[-1] += calories
        end
      end
    end

    def self.elves(input)
      parse(input)
        .sort
        .reverse
    end
  end
end
