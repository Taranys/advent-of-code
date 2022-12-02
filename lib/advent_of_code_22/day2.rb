# frozen_string_literal: true

module AdventOfCode22
  DECRYPT = {
    A: :rock,
    X: :rock,
    B: :paper,
    Y: :paper,
    C: :scissors,
    Z: :scissors
  }.freeze

  SHAPE_VALUE = {
    rock: 1,
    paper: 2,
    scissors: 3
  }.freeze

  class Match
    attr_accessor :opponent_choice, :my_choice

    def initialize(line, advanced)
      v1, v2 = line.split(" ")
      @opponent_choice = DECRYPT[v1.to_sym]
      @my_choice = advanced ? find_proper_choice(v2, @opponent_choice) : DECRYPT[v2.to_sym]
    end

    def find_proper_choice(expected, opponent_shape)
      choices = %i[rock paper scissors]

      case expected
      when "X"
        choices.find { |shape| confront(shape, opponent_shape) == :loose }
      when "Y"
        choices.find { |shape| confront(shape, opponent_shape) == :draw }
      when "Z"
        choices.find { |shape| confront(shape, opponent_shape) == :win }
      end
    end

    # rubocop:disable Metrics/CyclomaticComplexity
    def confront(shape1, shape2)
      return :draw if shape1 == shape2

      return :win if shape1 == :rock && shape2 == :scissors
      return :win if shape1 == :paper && shape2 == :rock
      return :win if shape1 == :scissors && shape2 == :paper

      :loose
    end
    # rubocop:enable Metrics/CyclomaticComplexity

    def outcome(shape1, shape2)
      result = confront(shape1, shape2)

      return 0 if result == :loose
      return 3 if result == :draw
      return 6 if result == :win
    end

    def my_score
      SHAPE_VALUE[@my_choice] + outcome(@my_choice, @opponent_choice)
    end
  end

  class Day2
    def self.compute_score(input, advanced: false)
      input
        .map { |line| Match.new(line, advanced) }
        .map(&:my_score)
        .sum
    end
  end
end
