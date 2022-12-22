require "./solver"

module AoC2022
  class Day22 < Solver
    struct Position
      property x
      property y

      def initialize(@x : Int32, @y : Int32)
      end
    end

    NEXT_FACING = {
      {'U', 'R'} => 'R',
      {'R', 'R'} => 'D',
      {'D', 'R'} => 'L',
      {'L', 'R'} => 'U',
      {'U', 'L'} => 'L',
      {'R', 'L'} => 'U',
      {'D', 'L'} => 'R',
      {'L', 'L'} => 'D',
    }

    FACING_VALUE = {
      'R' => 0,
      'D' => 1,
      'L' => 2,
      'U' => 3,
    }

    @open_tiles : Set(Position)
    @solid_walls : Set(Position)
    @path_steps : Array(Int32)
    @path_turns : Array(Char)

    def initialize(input : String)
      @open_tiles = Set(Position).new
      @solid_walls = Set(Position).new

      blobs = input.strip("\n").split("\n\n", 2)

      blobs[0].lines.each_with_index do |line, y|
        line.chars.each_with_index do |c, x|
          next if c == ' '
          @open_tiles << Position.new(x, y) if c == '.'
          @solid_walls << Position.new(x, y) if c == '#'
        end
      end

      @path_steps = blobs[1].scan(/(\d+)/).map { |m| m[0].to_i }
      @path_turns = blobs[1].scan(/([LR])/).map { |m| m[0][0] }
    end

    def part1 : String
      y_min = @open_tiles.map { |pos| pos.y }.min
      initial_position = @open_tiles.select { |pos| pos.y == y_min }.min_by { |pos| pos.x }

      final_position, final_facing = navigate(initial_position, 'R', edge_warps)

      code = 1000 * (final_position.y + 1) + 4 * (final_position.x + 1) + FACING_VALUE[final_facing]

      code.to_s
    end

    def part2 : String
      y_min = @open_tiles.map { |pos| pos.y }.min
      initial_position = @open_tiles.select { |pos| pos.y == y_min }.min_by { |pos| pos.x }

      final_position, final_facing = navigate(initial_position, 'R', cube_warps)

      code = 1000 * (final_position.y + 1) + 4 * (final_position.x + 1) + FACING_VALUE[final_facing]

      code.to_s
    end

    def navigate(initial_position : Position, initial_facing : Char, warps : Hash(Position, Position)) : Tuple(Position, Char)
      facing = NEXT_FACING[{initial_facing, 'L'}]
      position = initial_position

      @path_steps.zip(['R'] + @path_turns).each do |steps, turn|
        facing = NEXT_FACING[{facing, turn}]

        steps.times do
          tentative_position = case facing
                               when 'R'
                                 Position.new(position.x + 1, position.y)
                               when 'D'
                                 Position.new(position.x, position.y + 1)
                               when 'L'
                                 Position.new(position.x - 1, position.y)
                               when 'U'
                                 Position.new(position.x, position.y - 1)
                               else
                                 raise "a"
                               end

          if warps.has_key?(tentative_position)
            tentative_position = warps[tentative_position]
          end

          next if @solid_walls.includes?(tentative_position)

          if @open_tiles.includes?(tentative_position)
            position = tentative_position
          end
        end
      end

      {position, facing}
    end

    def edge_warps : Hash(Position, Position)
      warps = Hash(Position, Position).new

      points = @open_tiles | @solid_walls

      y_min = points.map { |pos| pos.y }.min
      y_max = points.map { |pos| pos.y }.max

      (y_min..y_max).each do |y|
        y_points = points.select { |pos| pos.y == y }
        x_min = y_points.map { |pos| pos.x }.min
        x_max = y_points.map { |pos| pos.x }.max

        warps[Position.new(x_min - 1, y)] = Position.new(x_max, y)
        warps[Position.new(x_max + 1, y)] = Position.new(x_min, y)
      end

      x_min = points.map { |pos| pos.x }.min
      x_max = points.map { |pos| pos.x }.max

      (x_min..x_max).each do |x|
        x_points = points.select { |pos| pos.x == x }
        y_min = x_points.map { |pos| pos.y }.min
        y_max = x_points.map { |pos| pos.y }.max

        warps[Position.new(x, y_min - 1)] = Position.new(x, y_max)
        warps[Position.new(x, y_max + 1)] = Position.new(x, y_min)
      end

      warps
    end

    def cube_warps : Hash(Position, Position)
      warps = Hash(Position, Position).new

      # this is hard :(

      warps
    end
  end
end
