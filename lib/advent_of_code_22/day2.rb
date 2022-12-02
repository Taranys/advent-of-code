# frozen_string_literal: true

module AdventOfCode22
  DECRYPT = {
    A: :rock,
    X: :rock,
    B: :paper,
    Y: :paper,
    C: :scissors,
    Z: :scissors,
  }

  class Match
    attr_accessor :opponent_choice, :my_choice

    def initialize(line, advanced)
      v1, v2 = line.split(' ')
      @opponent_choice = DECRYPT[v1.to_sym]
      @my_choice = advanced ? find_proper_choice(v2, @opponent_choice) : DECRYPT[v2.to_sym]
    end

    def find_proper_choice(expected, opponent_shape)
      choices = [:rock, :paper, :scissors]

      return choices.find { |shape| confront(shape, opponent_shape) == :loose } if(expected == 'X')
      return choices.find { |shape| confront(shape, opponent_shape) == :draw } if(expected == 'Y')
      return choices.find { |shape| confront(shape, opponent_shape) == :win } if(expected == 'Z')
    end

    def value(shape)
      case shape
      when :rock
        1
      when :paper
        2
      when :scissors
        3
      end
    end

    def confront(shape1, shape2)
      return :draw if shape1 == shape2

      return :win if shape1 == :rock && shape2 == :scissors
      return :win if shape1 == :paper && shape2 == :rock
      return :win if shape1 == :scissors && shape2 == :paper

      :loose
    end

    def outcome(shape1, shape2)
      result = confront(shape1, shape2)

      return 0 if result == :loose
      return 3 if result == :draw
      return 6 if result == :win
    end

    def my_score
      value(@my_choice) + outcome(@my_choice, @opponent_choice)
    end
  end

  class Day2
    def self.compute_score(input, advanced = false)
      input
        .map { |line| Match.new(line, advanced) }
        .map { |match| match.my_score }
        .sum
    end
  end
end