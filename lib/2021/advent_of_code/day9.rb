# frozen_string_literal: true

module AdventOfCode
  # SmokeBasin
  class SmokeBasin
    def initialize(input)
      @map = input.map.with_index { |line, x| line.chars.map.with_index { |v, y| Point.new(v.to_i, x, y) } }

      find_low_points
      low_points.each { |point| define_basin(point) }
    end

    def low_points
      @map.flatten.filter(&:low)
    end

    def basins
      @map.flatten.group_by(&:basin_core).to_a.map { |group| group[0].nil? ? 0 : group[1].size }
    end

    private

    def find_low_points
      @map.each_with_index do |line, row|
        line.each_with_index do |_, column|
          current = @map[row][column]
          current.low = true if adjacent_points(current.coordinate).all? { |adj| adj.risk_level > current.risk_level }
        end
      end
    end

    def define_basin(point)
      adjacent_points(point.coordinate).each do |adj|
        next unless adj.basin_core.nil?
        next if adj.risk_level == 10

        adj.basin_core = point.basin_core
        define_basin(adj)
      end
    end

    def adjacent_points(coordinate)
      row, column = coordinate
      adjacents = []

      adjacents << @map[row][column - 1] if column.positive?
      adjacents << @map[row][column + 1] unless @map[row][column + 1].nil?
      adjacents << @map[row - 1][column] if row.positive?
      adjacents << @map[row + 1][column] unless @map[row + 1].nil?

      adjacents
    end
  end

  # Point
  class Point
    attr_reader :low
    attr_accessor :basin_core

    def initialize(value, row, column)
      @value = value
      @row = row
      @column = column
      @basin_core = nil
    end

    def low=(value)
      @low = value
      @basin_core = self
    end

    def risk_level
      @value + 1
    end

    def coordinate
      [@row, @column]
    end
  end
end
