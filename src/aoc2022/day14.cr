require "json"

require "./solver"

module AoC2022
  class Day14 < Solver
    struct Position
      getter x
      getter y

      def initialize(@x : Int32, @y : Int32)
      end
    end

    class Map
      getter tiles
      @y_floor : Int32?

      def initialize(@tiles : Hash(Position, Char))
      end

      def y_floor : Int32
        @y_floor ||= @tiles.keys.map { |pos| pos.y }.max + 2
      end

      def pretty_print(with_floor : Bool) : String
        min_x = tiles.keys.map { |pos| pos.x }.min - 2
        max_x = tiles.keys.map { |pos| pos.x }.max + 2
        max_y = tiles.keys.map { |pos| pos.y }.max + 2
        num_zeroes = Math.log(max_y, 10).ceil.to_i

        buf = ""
        (0..max_y).each do |y|
          buf += "%#{num_zeroes}d " % y
          if with_floor && y == max_y
            buf += "#" * (max_x - min_x + 1)
          else
            (min_x..max_x).each do |x|
              pos = Position.new(x, y)
              if tiles.has_key?(pos)
                buf += tiles[pos]
              else
                buf += "."
              end
            end
          end
          buf += "\n"
        end
        buf
      end

      def clone : Map
        Map.new(@tiles.clone)
      end
    end

    SAND_SOURCE = Position.new(500, 0)

    @map : Map

    def initialize(input : String)
      wall_shapes = input.strip("\n").lines
        .map do |line|
          line.split(" -> ").map do |coords|
            x, y = coords.split(",", 2).map { |n| n.to_i }
            Position.new(x, y)
          end
        end

      tiles = Hash(Position, Char).new

      wall_shapes.each_with_index do |wall_shape, i|
        (1...wall_shape.size).each do |j|
          points = {wall_shape[j - 1], wall_shape[j]}
          if points[0].x == points[1].x
            y_values = [points[0].y, points[1].y].sort
            (y_values[0]..y_values[1]).each do |y|
              tiles[Position.new(points[0].x, y)] = '#'
            end
          elsif points[0].y == points[1].y
            x_values = [points[0].x, points[1].x].sort
            (x_values[0]..x_values[1]).each do |x|
              tiles[Position.new(x, points[0].y)] = '#'
            end
          else
            raise ":("
          end
        end
      end

      @map = Map.new(tiles)
    end

    def part1 : String
      map = @map.clone
      num_sand = 0
      while true
        new_sand = add_sand(map, false)
        if new_sand
          num_sand += 1
          map.tiles[new_sand] = 'o'
        else
          break
        end
      end
      num_sand.to_s
    end

    def part2 : String
      map = @map.clone
      num_sand = 0
      while true
        new_sand = add_sand(map, true)
        if new_sand
          num_sand += 1
          map.tiles[new_sand] = 'o'
          break if new_sand == SAND_SOURCE
        else
          break
        end
      end
      num_sand.to_s
    end

    private def add_sand(map : Map, with_floor : Bool) : Position?
      new_sand = SAND_SOURCE

      while true
        down = Position.new(new_sand.x, new_sand.y + 1)

        if !with_floor
          if down.y > map.tiles.keys.map { |pos| pos.y }.max
            return nil
          end
        end

        if is_free?(map, down, with_floor)
          new_sand = down
          next
        end

        down_left = Position.new(new_sand.x - 1, new_sand.y + 1)
        if is_free?(map, down_left, with_floor)
          new_sand = down_left
          next
        end

        down_right = Position.new(new_sand.x + 1, new_sand.y + 1)
        if is_free?(map, down_right, with_floor)
          new_sand = down_right
          next
        end

        break
      end

      return new_sand
    end

    private def is_free?(map : Map, position : Position, with_floor : Bool) : Bool
      if with_floor
        return false if position.y >= map.y_floor
      end
      !map.tiles.has_key?(position)
    end
  end
end
