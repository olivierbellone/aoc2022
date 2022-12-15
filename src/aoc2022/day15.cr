require "json"

require "./solver"

module AoC2022
  class Day15 < Solver
    struct Position
      getter x
      getter y

      def initialize(@x : Int64, @y : Int64)
      end

      def manhattan(other : Position) : Int64
        (other.x - x).abs + (other.y - y).abs
      end
    end

    struct Entry
      getter sensor
      getter beacon
      @sensor_range : Int64?

      def initialize(@sensor : Position, @beacon : Position)
      end

      def sensor_range : Int64
        @sensor_range ||= sensor.manhattan(beacon)
      end
    end

    @report : Array(Entry)

    def initialize(input : String)
      @report = input.strip("\n").lines
        .map do |line|
          m = line.match(/\ASensor at x=(?P<x_sensor>[-]?\d+), y=(?P<y_sensor>[-]?\d+): closest beacon is at x=(?P<x_beacon>[-]?\d+), y=(?P<y_beacon>[-]?\d+)\z/)

          raise "Unexpected input: #{line}" if m.nil?

          Entry.new(
            Position.new(m["x_sensor"].to_i, m["y_sensor"].to_i64),
            Position.new(m["x_beacon"].to_i, m["y_beacon"].to_i64),
          )
        end
    end

    def part1(row : Int64 = 2000000) : String
      covered_points = Set(Int64).new

      @report.each do |entry|
        dist_to_row = (entry.sensor.y - row).abs
        width = entry.sensor_range - dist_to_row

        ((entry.sensor.x - width)..(entry.sensor.x + width)).each do |x|
          pos = Position.new(x, row)
          covered_points << x if pos != entry.beacon
        end
      end

      covered_points.size.to_s
    end

    def part2(max : Int64 = 4000000) : String
      covered_ranges_per_row = Hash(Int64, Array(Range(Int64, Int64))).new

      @report.each do |entry|
        (0..max).each do |y|
          dist_to_row = (entry.sensor.y - y).abs
          width = entry.sensor_range - dist_to_row

          if width > 0
            covered_ranges_per_row[y] ||= Array(Range(Int64, Int64)).new
            covered_ranges_per_row[y] << ((entry.sensor.x - width)..(entry.sensor.x + width))
          end
        end
      end

      covered_ranges_per_row.each do |y, ranges|
        sorted_ranges = ranges.sort_by { |r| r.begin }
        highest = sorted_ranges.first.end

        sorted_ranges[1..-1].each do |r|
          if r.begin > highest + 1
            return ((r.first - 1) * 4000000 + y).to_s
          end
          if r.end > highest
            highest = r.end
          end
        end
      end

      raise "No solution found."
    end
  end
end
