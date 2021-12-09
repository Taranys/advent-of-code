# frozen_string_literal: true

module AdventOfCode
  # SmokeBasin
  class SmokeBasin
    def initialize(input)
      @map = input.map { |line| line.chars.map { |v| Point.new(v.to_i) } }

      find_low_points
    end

    def low_points
      @map.flatten.filter(&:low)
    end

    private

    def find_low_points
      @map.each_with_index do |line, row|
        line.each_with_index do |_, column|
          current = @map[row][column]
          current.low = true if adjacent_points(row, column).all? { |adj| adj.risk_level > current.risk_level }
        end
      end
    end

    # rubocop:disable Metrics/AbcSize
    def adjacent_points(row, column)
      adjacents = []

      adjacents << @map[row][column - 1] if column.positive?
      adjacents << @map[row][column + 1] unless @map[row][column + 1].nil?
      adjacents << @map[row - 1][column] if row.positive?
      adjacents << @map[row + 1][column] unless @map[row + 1].nil?

      adjacents
    end
    # rubocop:enable Metrics/AbcSize
  end

  # Point
  class Point
    attr_accessor :low

    def initialize(value)
      @value = value
    end

    def risk_level
      @value + 1
    end
  end
end
