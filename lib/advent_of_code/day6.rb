# frozen_string_literal: true

module AdventOfCode
  # Day 6
  class LanternFishPopulation
    attr_accessor :generations

    def initialize(existing)
      @generations = Array.new(9) { 0 }

      existing.each { |day| @generations[day] += 1 }
    end

    def next_day
      number_of_fishes = @generations.first
      @generations.rotate!
      @generations[6] += number_of_fishes
    end

    def count
      @generations.sum
    end
  end
end
