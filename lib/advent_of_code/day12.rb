# frozen_string_literal: true

module AdventOfCode
  class GPS
    attr_reader :result
    def initialize(input)
      @result = []
      @map = {}

      input.each do |line|
        a, b = line.split('-')

        @map[a] = Cave.new(a) unless @map.include?(a)
        @map[b] = Cave.new(b) unless @map.include?(b)

        @map[a].adjacents << @map[b]
        @map[b].adjacents << @map[a]
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
  end

  class Cave
    attr_reader :label
    attr_reader :adjacents

    def initialize(input)
      @label = input
      @adjacents = []
    end

    def small?
      @label.downcase == @label
    end
  end

  class Visitor
    attr_reader :paths, :result, :double
    attr_accessor :double

    def initialize(map, paths = ["start"], result = [], double = false)
      @map = map
      @paths = paths
      @result = result
      @double = double
    end

    def current
      @map[@paths.last]
    end

    def next(cave)
      Visitor.new(@map, [*@paths, cave.label], @result, double || (cave.small? && @paths.include?(cave.label)))
    end

    def visitable?(cave)
      return false if cave.label == "start"

      if cave.small? && @paths.include?(cave.label) && @double
        return false
      end

      true
    end
  end
end
