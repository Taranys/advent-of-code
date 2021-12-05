# frozen_string_literal: true

module AdventOfCode
  # Day 5
  class Day5
    def self.vents_positions(input)
      start, stop = input.split(" -> ").map { |coordinate| coordinate.split(",").map(&:to_i) }

      test(start, stop)
    end

    def self.test(start, stop)
      if start[1] == stop[1]
        start, stop = stop, start if start[0] > stop[0]
        (start[0]..stop[0]).to_a.map.with_index { |value| [value, start[1]] }
      elsif start[0] == stop[0]
        start, stop = stop, start if start[1] > stop[1]
        (start[1]..stop[1]).to_a.map.with_index { |value| [start[0], value] }
      else
        start, stop = stop, start if start[0] > stop[0]

        (start[0]..stop[0]).to_a.map.with_index do |_, index|
          [start[0] + index, start[1] < stop[1] ? start[1] + index : start[1] - index ]
        end
      end
    end
  end
end
