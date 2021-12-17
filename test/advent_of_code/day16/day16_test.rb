# frozen_string_literal: true

require "minitest/autorun"

require_relative "../helper"
require_relative "../../../lib/advent_of_code/day16"

module AdventOfCode
  class Day16Test < Minitest::Test
    EXAMPLE = '
'.split("\n").map(&:strip).reject(&:empty?)

    def test_part1
      # 0 001010110100111
      #   110 100 10100 00001
      #   001 000 1 00000000100 001100100110001011010011000010110011001

      # assert_equal true, Packet.decode_hexa("D2FE28").literal?
      # assert_equal 3, Packet.decode_hexa("D2FE28").subpackets.count
      # assert_equal 6, Packet.decode_hexa("D2FE28").version_sum
      #
      # assert_equal false, Packet.decode_hexa("38006F45291200").literal?
      # assert_equal 2, Packet.decode_hexa("38006F45291200").subpackets.size
      #
      # assert_equal 16, Packet.decode_hexa("8A004A801A8002F478").version_sum
      assert_equal 12, Packet.decode_hexa("620080001611562C8802118E34").version_sum
      # assert_equal 23, Packet.decode_hexa("C0015000016115A2E0802F182340").version_sum
      # assert_equal 31, Packet.decode_hexa("A0016C880162017C3686B18A3D4780").version_sum

      assert_equal 20, Packet.decode_hexa(Helper.load_input(16).first).version_sum
    end
  end
end
