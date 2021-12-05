# frozen_string_literal: true

module AdventOfCode
  # Day 5
  class Day5
    def self.vents_positions(input)
      start, stop = input.split(" -> ").map { |coordinate| coordinate.split(",").map(&:to_i) }

      if start[1] == stop[1]
        start, stop = stop, start if start[0] > stop[0]
        return (start[0]..stop[0]).to_a.map.with_index { |value| [value, start[1]] }
      elsif start[0] == stop[0]
        start, stop = stop, start if start[1] > stop[1]
        return (start[1]..stop[1]).to_a.map.with_index { |value| [start[0], value] }
      end

      []
    end
  end
end
