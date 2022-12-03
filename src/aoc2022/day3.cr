require "./solver"

module AoC2022
  class Day3 < Solver
    property rucksacks : Array(Array(Char))

    def initialize(input : String)
      @rucksacks = input
        .strip("\n")
        .split("\n")
        .map { |line| line.chars }
    end

    def part1 : String
      rucksacks.map do |contents|
        compartment_size = (contents.size / 2).to_i
        item = (contents[0..compartment_size] & contents[compartment_size..-1])[0]
        priority(item)
      end.sum.to_s
    end

    def part2 : String
      (2..rucksacks.size).step(3).map do |i|
        badge = (rucksacks[i - 2] & rucksacks[i - 1] & rucksacks[i])[0]
        priority(badge)
      end.sum.to_s
    end

    private def priority(item : Char) : Int32
      case item
      when 'a'..'z'
        item - 'a' + 1
      when 'A'..'Z'
        item - 'A' + 27
      else
        raise "Unknown item: #{item}"
      end
    end
  end
end
