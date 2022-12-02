# frozen_string_literal: true

require "minitest/autorun"

require_relative "../helper"
require_relative "../../../lib/2021/advent_of_code/day3"

module AdventOfCode
  class DiagnosticReportTest < Minitest::Test
    def test_most_common_bit
      diagnostic = DiagnosticReport.new(%w[010 101 001])
      assert_equal 0, diagnostic.most_common_bit
      assert_equal 1, diagnostic.less_common_bit

      assert_equal 0, diagnostic.most_common_bit(1)
      assert_equal 1, diagnostic.less_common_bit(1)

      assert_equal 1, diagnostic.most_common_bit(2)
      assert_equal 0, diagnostic.less_common_bit(2)
    end

    def test_gamma_epsilon
      input = %w[00100 11110 10110 10111 10101 01111 00111 11100 10000 11001 00010 01010]
      diagnostic = DiagnosticReport.new(input)

      assert_equal 22, diagnostic.gamma
      assert_equal 9, diagnostic.epsilon
      assert_equal 198, diagnostic.gamma * diagnostic.epsilon
    end

    def test_gamma_epsilon_full
      input = AdventOfCode::Helper.load_input(3)
      diagnostic = DiagnosticReport.new(input)

      assert_equal 2_972_336, diagnostic.gamma * diagnostic.epsilon
    end

    def test_oxygen_co2
      input = %w[00100 11110 10110 10111 10101 01111 00111 11100 10000 11001 00010 01010]
      diagnostic = DiagnosticReport.new(input)

      assert_equal 23, diagnostic.o2
      assert_equal 10, diagnostic.co2
    end

    def test_oxygen_co2_full
      input = AdventOfCode::Helper.load_input(3)
      diagnostic = DiagnosticReport.new(input)

      assert_equal 3_368_358, diagnostic.o2 * diagnostic.co2
    end

    def normalize_data(input)
      input.map(&:strip).map { |entry| entry.each_char.map(&:to_i) }
    end
  end
end
