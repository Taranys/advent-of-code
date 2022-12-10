# frozen_string_literal: true

require "matrix"

module AdventOfCode22
  module Day10

    class Parser
      def self.signal(input)
        signals = [1]
        input.map do |line|
          if line == 'noop'
            signals << signals.last
            next
          end

          addx = line.split(' ')[1].to_i
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
        @signal[tick-1]
      end
    end

  end
end
