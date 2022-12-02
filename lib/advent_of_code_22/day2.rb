# frozen_string_literal: true

module AdventOfCode22
  module Day2
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

    RESULT_VALUE = {
      win: 6,
      draw: 3,
      loose: 0
    }.freeze

    class Tournament
      def initialize(input, parser)
        @matches = input.map { |line| parser.to_match(line) }
      end

      def total_score
        @matches.map(&:score).sum
      end
    end

    class Match
      def initialize(my_shape, opponent_shape)
        @my_shape = my_shape
        @opponent_shape = opponent_shape
      end

      def result
        return :draw if @my_shape == @opponent_shape
        return :win if win?

        :loose
      end

      def score
        SHAPE_VALUE[@my_shape] + RESULT_VALUE[result]
      end

      def win?
        (@my_shape == :rock && @opponent_shape == :scissors) ||
          (@my_shape == :paper && @opponent_shape == :rock) ||
          (@my_shape == :scissors && @opponent_shape == :paper)
      end
    end

    class TwoShapesParser
      def to_match(line)
        opponent_shape, my_shape = line.split(" ").map { |letter| DECRYPT[letter.to_sym] }
        Match.new(my_shape, opponent_shape)
      end
    end

    class InstructionParser
      def to_match(line)
        opponent_letter, instruction = line.split(" ")

        opponent_shape = DECRYPT[opponent_letter.to_sym]
        my_shape = find_shape_from_instruction(instruction, opponent_shape)

        Match.new(my_shape, opponent_shape)
      end

      def find_shape_from_instruction(instruction, opponent_shape)
        choices = %i[rock paper scissors]

        case instruction
        when "X"
          choices.find { |shape| Match.new(shape, opponent_shape).result == :loose }
        when "Y"
          choices.find { |shape| Match.new(shape, opponent_shape).result == :draw }
        when "Z"
          choices.find { |shape| Match.new(shape, opponent_shape).result == :win }
        end
      end
    end
  end
end
