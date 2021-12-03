# frozen_string_literal: true

module AdventOfCode
  # Day 3
  class DiagnosticReport
    def initialize(input)
      @data = input.map(&:strip).map { |entry| entry.each_char.map(&:to_i) }
    end

    def most_common_bit(position = 0, data = @data)
      data.map { |v| v[position] }.count(0) > (data.size / 2) ? 0 : 1
    end

    def less_common_bit(position = 0, data = @data)
      most_common_bit(position, data).zero? ? 1 : 0
    end

    def gamma
      power_consumption(:most_common_bit)
    end

    def epsilon
      power_consumption(:less_common_bit)
    end

    def o2
      life_support(:most_common_bit)
    end

    def co2
      life_support(:less_common_bit)
    end

    private

    def power_consumption(bit_method)
      @data[0].map.with_index { |_, i| send(bit_method, i) }.join.to_i(2)
    end

    def life_support(bit_method)
      data = @data
      @data[0].size.times do |index|
        data = data.select { |line| send(bit_method, index, data) == line[index] }
        break if data.size == 1
      end
      data[0].join.to_i(2)
    end
  end
end
