# frozen_string_literal: true

require "matrix"

module AdventOfCode22
  module Day10
    class Parser
      def self.signal(input)
        signals = [1]
        input.map do |line|
          if line == "noop"
            signals << signals.last
            next
          end

          addx = line.split(" ")[1].to_i
          signals << signals.last
          signals << signals.last + addx
        end

        signals
      end
    end

    class CPU
      def initialize(signal)
        @signal = signal
      end

      def register_at(tick)
        @signal[tick - 1]
      end
    end

    class CRT
      def initialize
        @screen = Matrix.build(6, 40) { "." }
      end

      def draw(tick, pixel)
        @screen[tick / 40, tick % 40] = "#" if tick % 40 == pixel - 1 || tick % 40 == pixel || tick % 40 == pixel + 1
      end

      def print
        @screen.row_vectors.map { |row| row.to_a.join }
      end
    end
  end
end
