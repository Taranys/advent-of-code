# frozen_string_literal: true

module AdventOfCode
  # Day 7
  class Day7
    def self.align_crabs(positions, type)
      positions.map { |i| coast_to_move_all_crab(positions, i, type) }.min
    end

    def self.coast_to_move_all_crab(positions, index, type)
      if type == :simple
        positions.map { |pos| (pos - index).abs }.sum
      else
        positions.map { |pos| ((pos - (index + 1)).abs + 1).times.sum }.sum
      end
    end
  end
end
