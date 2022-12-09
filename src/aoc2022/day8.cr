require "./solver"

module AoC2022
  class Day8 < Solver
    @grid : Array(Array(Int32))

    def initialize(input : String)
      @grid = input.strip("\n")
        .lines
        .map { |line| line.chars.map { |c| c.to_i } }
    end

    def part1 : String
      (0...@grid[0].size).map do |x|
        (0...@grid.size).count { |y| is_visible?(x, y) }
      end.sum.to_s
    end

    def part2 : String
      (0...@grid[0].size).map do |x|
        (0...@grid.size).map { |y| scenic_score(x, y) }.max
      end.max.to_s
    end

    private def is_visible?(x : Int32, y : Int32) : Bool
      grid_slices(x, y).any? do |slice|
        slice.all? { |h| h < @grid[x][y] }
      end
    end

    private def scenic_score(x : Int32, y : Int32) : Int32
      grid_slices(x, y).map do |slice|
        (slice.index { |h| h >= @grid[x][y] } || (slice.size - 1)) + 1
      end.reduce(1) { |acc, s| acc * s }
    end

    private def grid_slices(x : Int32, y : Int32) : Tuple(Array(Int32), Array(Int32), Array(Int32), Array(Int32))
      {
        @grid[x][0...y].reverse,                    # left slice
        @grid[x][(y + 1)...(@grid[0].size)],        # right slice
        @grid.transpose[y][0...x].reverse,          # up slice
        @grid.transpose[y][(x + 1)...(@grid.size)], # down slice
      }
    end
  end
end
