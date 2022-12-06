require "./solver"

module AoC2022
  class Day6 < Solver
    property datastream : String

    def initialize(input : String)
      @datastream = input.strip("\n")
    end

    def part1 : String
      detect_marker(@datastream, 4).to_s
    end

    def part2 : String
      detect_marker(@datastream, 14).to_s
    end

    private def detect_marker(buffer : String, length : Int32) : Int32
      (0..(@datastream.size - length)).each do |i|
        if @datastream[i...(i + length)].chars.to_set.size == length
          return i + length
        end
      end
      return -1
    end
  end
end
