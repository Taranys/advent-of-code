# frozen_string_literal: true

module AdventOfCode22
  # Day 1 of the advent of code 2021
  class Day1
    def self.elves(input)
      input
        .map(&:to_i)
        .reduce([]) do |line, values|
          if line.zero?
            values << 0
          else
            values[-1] = values[-1] + current
          end
        end
        .sort.reverse
    end
  end
end
