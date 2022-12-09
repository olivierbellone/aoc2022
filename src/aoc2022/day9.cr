require "./solver"

module AoC2022
  class Day9 < Solver
    struct Point
      property x, y

      def initialize(@x : Int32, @y : Int32)
      end

      def move(dir : Char) : Point
        case dir
        when 'U'
          self.y -= 1
        when 'D'
          self.y += 1
        when 'R'
          self.x += 1
        when 'L'
          self.x -= 1
        end

        self
      end

      TRAIL_VECTORS = {
        {-2, -2} => {-1, -1},
        {-2, -1} => {-1, -1},
        {-2, 0}  => {-1, 0},
        {-2, 1}  => {-1, 1},
        {-2, 2}  => {-1, 1},
        {-1, -2} => {-1, -1},
        {-1, -1} => {0, 0},
        {-1, 0}  => {0, 0},
        {-1, 1}  => {0, 0},
        {-1, 2}  => {-1, 1},
        {0, -2}  => {0, -1},
        {0, -1}  => {0, 0},
        {0, 0}   => {0, 0},
        {0, 1}   => {0, 0},
        {0, 2}   => {0, 1},
        {1, -2}  => {1, -1},
        {1, -1}  => {0, 0},
        {1, 0}   => {0, 0},
        {1, 1}   => {0, 0},
        {1, 2}   => {1, 1},
        {2, -2}  => {1, -1},
        {2, -1}  => {1, -1},
        {2, 0}   => {1, 0},
        {2, 1}   => {1, 1},
        {2, 2}   => {1, 1},
      }

      def trail(other : Point) : Point
        vector = TRAIL_VECTORS[{other.x - x, other.y - y}]
        return Point.new(x + vector[0], y + vector[1])
      end
    end

    class Rope
      getter knots : Array(Point)

      def initialize(num_knots : Int32)
        @knots = (0...num_knots).map { Point.new(0, 0) }
      end

      def move_head(dir : Char)
        @knots[0] = @knots[0].move(dir)

        (1...@knots.size).each do |i|
          @knots[i] = @knots[i].trail(@knots[i - 1])
        end
      end
    end

    @motions : Array(Tuple(Char, Int32))

    def initialize(input : String)
      @motions = input.strip("\n").lines
        .map do |line|
          parts = line.split(" ")
          {parts[0][0], parts[1].to_i}
        end
    end

    def part1 : String
      rope = Rope.new(2)
      simulate(rope).to_s
    end

    def part2 : String
      rope = Rope.new(10)
      simulate(rope).to_s
    end

    private def simulate(rope) : Int32
      visited = Set(Point).new

      @motions.each do |dir, dist|
        dist.times do
          rope.move_head(dir)
          visited << rope.knots.last
        end
      end

      visited.size
    end
  end
end
