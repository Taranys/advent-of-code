# frozen_string_literal: true

module AdventOfCode22
  module Day4
    class Parser
      def self.section_assignments(input)
        input.map do |line|
          s1, s2 = line.split(',').map { |value| value.split('-') }

          SectionAssignment.new(
            (s1[0]..s1[1]).to_a,
            (s2[0]..s2[1]).to_a,
          )
        end
      end
    end

    class SectionAssignment
      def initialize(assignment1, assignment2)
        @assignment1 = assignment1
        @assignment2 = assignment2
      end

      def fully_overlapse?
        overlapse.size == @assignment1.size || overlapse.size == @assignment2.size
      end

      def overlapse?
        overlapse.size != 0
      end

      private

      def overlapse
        @assignment1.intersection(@assignment2)
      end
    end
  end
end
