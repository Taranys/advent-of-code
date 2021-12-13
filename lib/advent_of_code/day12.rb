# frozen_string_literal: true

module AdventOfCode
  # GPS
  class GPS
    attr_reader :result

    def initialize(input)
      @result = []
      @map = {}

      input.each do |line|
        a, b = line.split("-")

        fill_map(a, b)
      end
    end

    def go_to_end
      result = []
      go_deep(["start"], result)
      result
    end

    def go_deep(paths, result)
      current = @map[paths.last]

      result << paths if current.label == "end"

      current.adjacents.each do |cave|
        next if cave.small? && paths.include?(cave.label)

        go_deep([*paths, cave.label], result)
      end
    end

    def go_to_end_twice
      go_deep_twice(Visitor.new(@map))
      @result
    end

    def go_deep_twice(visitor)
      current = visitor.current

      if current.label == "end"
        @result << visitor.paths
        return
      end

      current.adjacents.each do |cave|
        next unless visitor.visitable?(cave)

        go_deep_twice(visitor.next(cave))
      end
    end

    private

    def fill_map(cave1, cave2)
      @map[cave1] = Cave.new(cave1) unless @map.include?(cave1)
      @map[cave2] = Cave.new(cave2) unless @map.include?(cave2)

      @map[cave1].adjacents << @map[cave2]
      @map[cave2].adjacents << @map[cave1]
    end
  end

  # Cave
  class Cave
    attr_reader :label, :adjacents

    def initialize(input)
      @label = input
      @adjacents = []
    end

    def small?
      @label.downcase == @label
    end
  end

  # Visitor
  class Visitor
    attr_reader :paths, :result
    attr_accessor :double

    def initialize(map, paths = ["start"], result = [], double: false)
      @map = map
      @paths = paths
      @result = result
      @double = double
    end

    def current
      @map[@paths.last]
    end

    def next(cave)
      Visitor.new(@map, [*@paths, cave.label], @result, double: double || (cave.small? && @paths.include?(cave.label)))
    end

    def visitable?(cave)
      return false if cave.label == "start"

      return false if cave.small? && @paths.include?(cave.label) && @double

      true
    end
  end
end
