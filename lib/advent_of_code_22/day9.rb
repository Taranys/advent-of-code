# frozen_string_literal: true

require "matrix"

module AdventOfCode22
  module Day9
    DIRECTION = {
      R: :right,
      U: :up,
      L: :left,
      D: :down
    }
    Move = Struct.new(:direction, :step)
    Position = Struct.new(:row, :col)

    class Parser
      def self.rope_movements(input)
        input.map do |line|
          direction, steps = line.split(" ")
          Move.new(DIRECTION[direction.to_sym], steps.to_i)
        end
      end
    end

    class RopeDimension
      def initialize
        @dim = Matrix.zero(1000)
        @head = Position.new(0,0)
        @tail = Position.new(0,0)
        mark_tail_position
      end

      def apply(move)
        # p [move.direction, move.step]
        move.step.times do
          move_head(move.direction)
          tail_follow
          mark_tail_position
          # p @tail
        end
      end

      def visited
        @dim.to_a
      end

      private

      def tail_follow
        vert_diff = @head.row - @tail.row
        horiz_diff = @head.col - @tail.col

        row = @tail.row
        row = @head.row-1 if vert_diff > 1
        row = @head.row+1 if vert_diff < -1

        col = @tail.col
        col = @head.col-1 if horiz_diff > 1
        col = @head.col+1 if horiz_diff < -1

        # force diag
        if @tail.row != row && horiz_diff != 0
          col = @head.col
        elsif @tail.col != col && vert_diff != 0
          row = @head.row
        end

        @tail = Position.new(row, col)
        # p @tail
        # if vert_diff == 0
        #   if horiz_diff > 0
        #     @tail = Position.new(@head.row, @head.col-1)
        #   elsif horiz_diff < 0
        #     @tail = Position.new(@head.row, @head.col+1)
        #   end
        # elsif horiz_diff == 0
        #   if vert_diff > 0
        #     @tail = Position.new(@head.row, @head.col-1)
        #   elsif vert_diff < 0
        #     @tail = Position.new(@head.row, @head.col+1)
        #   end
        # end
      end

      def mark_tail_position
        @dim[@tail.row, @tail.col] = 1
      end

      def move_head(direction)
        case direction
        when :up
          @head = Position.new(@head.row+1, @head.col)
        when :right
          @head = Position.new(@head.row, @head.col+1)
        when :down
          @head = Position.new(@head.row-1, @head.col)
        when :left
          @head = Position.new(@head.row, @head.col-1)
        else
          raise "Error #{direction}"
        end
      end
    end
  end
end
