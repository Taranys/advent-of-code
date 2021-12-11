# frozen_string_literal: true

module AdventOfCode
  class Cave
    attr_reader :octopuses

    def initialize(input)
      @octopuses = []

      map = input.map { |line| line.chars.map { |light_value| Octopus.new(light_value) } }

      map.each_with_index do |line, i|
        line.each_with_index do |current, j|
          current.adjacents = find_adjacents(map, i, j)
          @octopuses << current
        end
      end
    end

    def steps(value)
      value.times do
        @octopuses.each(&:increase_light)
        @octopuses.each(&:clean_up)
      end

      self
    end

    def synchronized_step
      10000000.times do |step|
        @octopuses.each(&:increase_light)
        @octopuses.each(&:clean_up)
        return (step + 1) if @octopuses.all? { |octopus| octopus.light_value == 0 }
      end
    end

    private

    def find_adjacents(map, i, j)
      result = []

      result << map[i-1][j-1] if i > 0 && j > 0
      result << map[i-1][j] if i > 0
      result << map[i-1][j+1] if i > 0 && j < (map[0].size - 1)

      result << map[i][j-1] if j > 0
      result << map[i][j+1] if j < (map[0].size - 1)

      result << map[i+1][j-1] if i < (map.size - 1) && j > 0
      result << map[i+1][j] if i < (map.size - 1)
      result << map[i+1][j+1] if i < (map.size - 1) && j < (map[0].size - 1)

      result
    end
  end

  class Octopus
    attr_reader :flash_count, :light_value
    attr_accessor :adjacents

    def initialize(light_value)
      @light_value = light_value.to_i
      @flash_count = 0
      @adjacents = []
    end

    def increase_light
      @light_value += 1
      if @light_value == 10
        @adjacents.each(&:increase_light)
      end
    end

    def clean_up
      if @light_value >= 10
        @flash_count += 1
        @light_value = 0
      end
    end
  end
end
