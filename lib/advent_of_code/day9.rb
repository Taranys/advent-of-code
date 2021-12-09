# frozen_string_literal: true

module AdventOfCode
  class Point
    attr_reader :x, :y

    def initialize(map, x, y)
      @map = map
      @x = x
      @y = y
    end

    def adjacents
      adjacents = []

      adjacents << Point.new(@map, @x, @y - 1) if @y > 0
      adjacents << Point.new(@map, @x, @y + 1) unless @map[@x][@y + 1].nil?
      adjacents << Point.new(@map, @x - 1, @y) if @x > 0
      adjacents << Point.new(@map, @x + 1, @y) unless @map[@x + 1].nil?

      adjacents
    end

    def value
      @map[@x][@y]
    end
  end

  # Day 9
  class Day9
    def initialize(input)
      @map = input.map { |line| line.chars.map(&:to_i) }
    end

    def low_points
      result = @map.map.with_index do |line, row|
        line.map.with_index do |_, column|
          point = Point.new(@map, row, column)
          point.adjacents.all? { |adj| adj.value > point.value } ? point.value : -1
        end
      end

      result.flatten.filter { |v| v != -1  }
    end

  end
end
