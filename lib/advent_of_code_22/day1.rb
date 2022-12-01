# frozen_string_literal: true

module AdventOfCode22
  # Day 1 of the advent of code 2021
  class Day1
    def self.elves(input)
      all_elves = []
      current = 0
      values = input.map(&:to_i)
      values.each do |value|
        if value == 0
          all_elves << current
          current = 0
        else
          current = current + value
        end
      end

      all_elves.sort.reverse
    end
  end
end