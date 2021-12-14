# frozen_string_literal: true

module AdventOfCode
  class Day14
    def self.day14(input, step)
      template, *mapping = input

      insertions = mapping.map { |line| line.split(" -> ") }.to_h
      counts = mapping.map { |line| [line.split(" -> ")[0], 0] }.to_h

      template.chars.each_cons(2) do |pair|
        counts[pair.join] += 1
      end

      step.times do
        tmp = counts.transform_values { 0 }

        counts.each do |key, value|
          a, b = key.chars
          new_char = insertions[key]

          tmp["#{a}#{new_char}"] += value
          tmp["#{new_char}#{b}"] += value
        end

        counts = tmp
      end

      result = {}
      counts.each do |key, value|
        a, b = key.chars

        result[a] = 0 unless result.include? a
        result[a] += value
      end

      result[template.chars.last] += 1

      result
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
