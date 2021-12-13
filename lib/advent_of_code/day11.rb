# frozen_string_literal: true

module AdventOfCode
  # Cave
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
      10_000_000.times do |step|
        @octopuses.each(&:increase_light)
        @octopuses.each(&:clean_up)
        return (step + 1) if @octopuses.all? { |octopus| octopus.light_value.zero? }
      end
    end

    private

    def find_adjacents(map, row, column)
      result = []

      result << map[row - 1][column - 1] if row.positive? && column.positive?
      result << map[row - 1][column] if row.positive?
      result << map[row - 1][column + 1] if row.positive? && column < (map[0].size - 1)

      result << map[row][column - 1] if column.positive?
      result << map[row][column + 1] if column < (map[0].size - 1)

      result << map[row + 1][column - 1] if row < (map.size - 1) && column.positive?
      result << map[row + 1][column] if row < (map.size - 1)
      result << map[row + 1][column + 1] if row < (map.size - 1) && column < (map[0].size - 1)

      result
    end
  end

  # Octopus
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
      @adjacents.each(&:increase_light) if @light_value == 10
    end

    def clean_up
      return unless @light_value >= 10

      @flash_count += 1
      @light_value = 0
    end
  end
end
