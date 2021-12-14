# frozen_string_literal: true

module AdventOfCode
  class Day14
    def self.day14(input, step)
      template = input.shift

      insertions = input.map { |line| line.split(" -> ") }.to_h
      p insertions

      polymers = template.chars

      step.times do
        polymers = insert_polymer(insertions, polymers)
      end

      polymers
    end

    def self.insert_polymer(insertions, polymers)
      next_polymers = []

      polymers.each_cons(2) do |pair|
        next_polymers += [pair[0], insertions[pair.join]]
      end

      [*next_polymers, polymers.last]
    end
  end
end
