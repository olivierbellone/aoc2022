require "./solver"

module AoC2022
  class Day18 < Solver
    alias Position = Tuple(Int32, Int32, Int32)

    @lava : Set(Position)

    @min_x : Int32
    @max_x : Int32
    @min_y : Int32
    @max_y : Int32
    @min_z : Int32
    @max_z : Int32

    def initialize(input : String)
      @lava = input.strip("\n").lines
        .map do |line|
          x, y, z = line.split(",", 3).map { |n| n.to_i }
          {x, y, z}
        end.to_set

      @min_x = @lava.map { |x, _, _| x }.min - 1
      @max_x = @lava.map { |x, _, _| x }.max + 1
      @min_y = @lava.map { |_, y, _| y }.min - 1
      @max_y = @lava.map { |_, y, _| y }.max + 1
      @min_z = @lava.map { |_, _, z| z }.min - 1
      @max_z = @lava.map { |_, _, z| z }.max + 1
    end

    def part1 : String
      @lava.map { |cube| neighbors(cube).count { |neighbor| !@lava.includes?(neighbor) } }.sum.to_s
    end

    def part2 : String
      steam = bfs({@min_x, @min_y, @min_z})

      steam.map do |cube|
        neighbors(cube).count { |neighbor| @lava.includes?(neighbor) }
      end.sum.to_s
    end

    private def neighbors(cube : Position) : Enumerable(Position)
      x, y, z = cube
      return [
        {x - 1, y, z},
        {x + 1, y, z},
        {x, y - 1, z},
        {x, y + 1, z},
        {x, y, z - 1},
        {x, y, z + 1},
      ]
    end

    # Returns true if a cube can be entered, i.e. if it's not occupied by lava
    # or out of bounds.
    private def can_enter?(cube : Position) : Bool
      return false if @lava.includes?(cube)

      x, y, z = cube

      (@min_x..@max_x).includes?(x) &&
        (@min_y..@max_y).includes?(y) &&
        (@min_z..@max_z).includes?(z)
    end

    private def bfs(cube : Position) : Set(Position)
      visited = [cube].to_set
      queue = [cube]

      while !queue.empty?
        s = queue.shift

        neighbors(s).each do |neighbor|
          if !visited.includes?(neighbor) && can_enter?(neighbor)
            visited << neighbor
            queue << neighbor
          end
        end
      end

      visited
    end
  end
end
