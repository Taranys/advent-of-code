# frozen_string_literal: true

module AdventOfCode
  # Day 7
  class Day7
    def self.align_crabs(positions)
      positions.map.with_index { |i| coast_to_move_all_crab(positions, i) }.min
    end

    def self.coast_to_move_all_crab(positions, i)
      positions.map { |pos| (pos - i).abs }.sum
    end
  end
end
