# frozen_string_literal: true

require "minitest/autorun"

require_relative "../helper"
require_relative "../../../lib/advent_of_code/day16"

module AdventOfCode
  class Day16Test < Minitest::Test
    EXAMPLE = '
'.split("\n").map(&:strip).reject(&:empty?)

    def test_part1
      assert_equal true, Packet.decode_hexa("D2FE28").literal?
      assert_equal 3, Packet.decode_hexa("D2FE28").subpackets.count
      assert_equal 6, Packet.decode_hexa("D2FE28").version_sum

      assert_equal false, Packet.decode_hexa("38006F45291200").literal?
      assert_equal 2, Packet.decode_hexa("38006F45291200").subpackets.size

      assert_equal 16, Packet.decode_hexa("8A004A801A8002F478").version_sum
      assert_equal 12, Packet.decode_hexa("620080001611562C8802118E34").version_sum
      assert_equal 23, Packet.decode_hexa("C0015000016115A2E0802F182340").version_sum
      assert_equal 31, Packet.decode_hexa("A0016C880162017C3686B18A3D4780").version_sum

      assert_equal 967, Packet.decode_hexa(Helper.load_input(16).first).version_sum
    end

    def test_part2
      assert_equal 3, Packet.decode_hexa("C200B40A82").value
      assert_equal 54, Packet.decode_hexa("04005AC33890").value
      assert_equal 7, Packet.decode_hexa("880086C3E88112").value
      assert_equal 9, Packet.decode_hexa("CE00C43D881120").value
      assert_equal 1, Packet.decode_hexa("D8005AC2A8F0").value
      assert_equal 0, Packet.decode_hexa("F600BC2D8F").value
      assert_equal 0, Packet.decode_hexa("9C005AC2F8F0").value

      assert_equal 12883091136209, Packet.decode_hexa(Helper.load_input(16).first).value
    end
  end
end
