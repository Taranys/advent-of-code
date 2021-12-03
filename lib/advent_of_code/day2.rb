# frozen_string_literal: true

module AdventOfCode
  # Day 2 submarine
  class Day2
    attr_accessor :horizontal, :depth, :aim

    def initialize
      @horizontal = 0
      @depth = 0
      @aim = 0
    end

    def move(input)
      input.each do |line|
        direction, value = line.split
        compute_position(direction, value)
      end

      self
    end

    def move_with_aim(input)
      input.each do |line|
        direction, value = line.split
        compute_position_with_aim(direction, value)
      end

      self
    end

    private

    def compute_position(direction, value)
      case direction
      when "forward"
        @horizontal += value.to_i
      when "down"
        @depth += value.to_i
      when "up"
        @depth -= value.to_i
      end
    end

    def compute_position_with_aim(direction, value)
      case direction
      when "forward"
        @horizontal += value.to_i
        @depth += value.to_i * @aim
      when "down"
        @aim += value.to_i
      when "up"
        @aim -= value.to_i
      end
    end
  end
end
