require "./solver"

module AoC2022
  class Day4 < Solver
    property assignments : Array(Tuple(Range(Int32, Int32), Range(Int32, Int32)))

    def initialize(input : String)
      @assignments = input
        .strip("\n")
        .split("\n")
        .map do |line|
          Tuple(Range(Int32, Int32), Range(Int32, Int32)).from(
            line.split(",").map do |sections|
              Range.new(
                *Tuple(Int32, Int32).from(
                  sections.split("-").map { |n| n.to_i }
                )
              )
            end
          )
        end
    end

    def part1 : String
      assignments
        .count { |ranges| ranges_covered?(ranges[0], ranges[1]) }
        .to_s
    end

    def part2 : String
      assignments
        .count { |ranges| ranges_overlap?(ranges[0], ranges[1]) }
        .to_s
    end

    # Checks whether range a is fully covered by range b or vice-versa.
    private def ranges_covered?(a : Range(Int32, Int32), b : Range(Int32, Int32)) : Bool
      ((b.begin >= a.begin) && (b.end <= a.end)) ||
        ((a.begin >= b.begin) && (a.end <= b.end))
    end

    # Checks whether ranges a and b overlap.
    private def ranges_overlap?(a : Range(Int32, Int32), b : Range(Int32, Int32)) : Bool
      (b.end >= a.begin) && (b.begin <= a.end)
    end
  end
end
