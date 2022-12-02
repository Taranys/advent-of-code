# frozen_string_literal: true

module AdventOfCode
  class Player
    attr_reader :score

    def initialize(position)
      @position = position
      @score = 0
    end

    def move(value)
      @position = ((@position - 1) + value) % 10 + 1
      @score += @position
    end
  end

  class Dice
    attr_reader :roll_count

    def initialize
      @current_value = 0
      @roll_count = 0
    end

    def roll
      @current_value += 1
      @roll_count += 1

      @current_value = 1 if @current_value == 101

      @current_value
    end
  end
end
