require "./solver"

module AoC2022
  class Day25 < Solver
    SNAFU_VALUES = {
      '=' => -2_i64,
      '-' => -1_i64,
      '0' => 0_i64,
      '1' => 1_i64,
      '2' => 2_i64,
    }

    BASE5_SNAFU = {
      '0' => {'0', false},
      '1' => {'1', false},
      '2' => {'2', false},
      '3' => {'=', true},
      '4' => {'-', true},
      '5' => {'0', true},
    }

    @fuel_requirements : Array(String)

    def initialize(input : String)
      @fuel_requirements = input.strip("\n").lines.to_a
    end

    def part1 : String
      decimal_to_snafu(@fuel_requirements.map { |req| snafu_to_decimal(req) }.sum)
    end

    def part2 : String
      "".to_s
    end

    private def snafu_to_decimal(snafu : String) : Int64
      snafu.chars.reverse
        .map_with_index { |d, i| SNAFU_VALUES[d] * 5_i64 ** i.to_i64 }
        .reduce(0_i64) { |acc, s| acc + s }
    end

    private def decimal_to_snafu(dec : Int64) : String
      carry = false
      dec.to_s(base: 5).chars.reverse.map do |c|
        if carry
          c += 1
          carry = false
        end

        snafu_digit, carry = BASE5_SNAFU[c]
        snafu_digit
      end.reverse.join("")
    end
  end
end
