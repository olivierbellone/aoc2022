require "json"

require "./solver"

module AoC2022
  class Day13 < Solver
    DIVIDER_PACKETS = [
      JSON.parse("[[2]]"),
      JSON.parse("[[6]]"),
    ]

    @packets : Array(JSON::Any)

    def initialize(input : String)
      @packets = input.strip("\n")
        .lines
        .reject { |line| line.empty? }
        .map { |line| JSON.parse(line) }
    end

    def part1 : String
      indices = Array(Int32).new
      @packets.each_slice(2).with_index do |(left, right), i|
        next unless compare(left, right) == -1
        indices << (i + 1)
      end
      indices.sum.to_s
    end

    def part2 : String
      ordered = (@packets + DIVIDER_PACKETS).sort { |a, b| compare(a, b) }
      index_1 = ordered.index!(DIVIDER_PACKETS[0]) + 1
      index_2 = ordered.index!(DIVIDER_PACKETS[1]) + 1
      (index_1 * index_2).to_s
    end

    # Compares two values and returns -1 if they are in the right order, 1 if
    # they are not in the right order, and 0 if a decision cannot be made.
    private def compare(left : JSON::Any, right : JSON::Any) : Int32
      left_i = left.as_i64?
      left_a = left.as_a?
      right_i = right.as_i64?
      right_a = right.as_a?

      if left_i && right_i
        r = left_i <=> right_i
        return r if r != 0
      elsif left_a && right_a
        n = [left_a.size, right_a.size].min
        (0...n).each do |i|
          r = compare(left[i], right[i])
          return r if r != 0
        end
        if left_a.size < right_a.size
          return -1
        elsif right_a.size < left_a.size
          return 1
        end
      elsif left_i && right_a
        r = compare(JSON.parse([left_i].to_json), right)
        return r if r != 0
      elsif left_a && right_i
        r = compare(left, JSON.parse([right_i].to_json))
        return r if r != 0
      else
        raise "Unexpected types."
      end

      0
    end
  end
end
