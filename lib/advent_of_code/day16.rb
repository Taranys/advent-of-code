# frozen_string_literal: true

module AdventOfCode
  # PacketDecoder
  class Packet
    attr_reader :subpackets

    def self.decode_hexa(packet)
      bin = packet.chars.map { |x| x.hex.to_s(2).rjust(4, "0") }.join

      decode(bin)
    end

    def self.decode(bin)
      Packet.new(bin[0..2].to_i(2), bin[3..5].to_i(2), bin[6..-1])
    end

    def initialize(version, type_id, content)
      @version = version
      @type_id = type_id
      @subpackets = []

      parse_literal(content) if literal?

      if operator?
        @length_type_id = content[0].to_i(2)
        if @length_type_id == 0
          parse_operator_0(content)
        else
          parse_operator_1(content)
        end
      end
    end

    def parse_literal(content)
      i = 0
      while content[i] == "1"
        @subpackets << content[i..(i+4)]
        i += 5
      end
      @subpackets << content[i..(i+4)]
    end

    def parse_operator_0(content)
      @total_length = content[1..15].to_i(2)

      i = 0
      while i < @total_length
        p ["=> 0", i, @total_length, @subpackets, content]
        sp = Packet.decode(content[(16+i)..-1])
        @subpackets << sp
        i += sp.size
      end
    end

    def parse_operator_1(content)
      @number_sub_packet = content[1..11].to_i(2)

      @number_sub_packet.times do ||
        i = @subpackets.map { |sp| sp.size }.sum
        # p ["=> 1", i, @number_sub_packet, @subpackets, content]
        @subpackets << Packet.decode(content[(12+i)..-1])
      end
    end

    def literal?
      @type_id == 4
    end

    def operator?
      !literal?
    end

    def size
      # p @length_type_id
      # return 3 + 3 + 16 + @length_type_id unless @length_type_id.nil?

      s = 3 + 3
      s += 16 unless @total_length.nil?
      s += 12 unless @number_sub_packet.nil?
      s + @subpackets.map { |sp| sp.size }.sum
    end

    def version_sum
      return @version if literal?

      @version + @subpackets.map { |sp| sp.version_sum }.sum
    end
  end
end
