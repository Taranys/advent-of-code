module AdventOfCode
  class Day2
    attr_accessor :horizontal, :depth

    def initialize
      @horizontal = 0
      @depth = 0
    end

    def move(input)
      input.each do |line|
        direction, value = line.split

        case direction
        when "forward"
          @horizontal = @horizontal + value.to_i
        when "down"
          @depth = @depth + value.to_i
        when "up"
          @depth = @depth - value.to_i
        end
      end

      self
    end
  end
end
