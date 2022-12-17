require "./solver"

module AoC2022
  class Day17 < Solver
    alias Position = Tuple(Int64, Int64)

    @jet_pattern : Array(Char)

    def initialize(input : String)
      @jet_pattern = input.strip("\n").chars
    end

    def part1 : String
      room = (0_i64..6_i64).map { |x| {x, 0_i64} }.to_set

      top = 0_i64
      i = 0_i64

      (0_i64...2022_i64).each do |t|
        piece = get_piece(t % 5, top + 4)
        while true
          if @jet_pattern[i] == '<'
            piece = move_left(piece)
            piece = move_right(piece) if !(piece & room).empty?
          else
            piece = move_right(piece)
            piece = move_left(piece) if !(piece & room).empty?
          end

          i = (i + 1) % @jet_pattern.size

          piece = move_down(piece)
          if !(piece & room).empty?
            piece = move_up(piece)
            room |= piece
            top = room.map { |_, y| y }.max
            break
          end
        end
      end

      top.to_s
    end

    def part2 : String
      room = (0_i64..6_i64).map { |x| {x, 0_i64} }.to_set

      top = 0_i64
      i = 0_i64
      t = 0_i64
      skipped = 0_i64

      while t < 1000000000000_i64
        piece = get_piece(t % 5, top + 4)
        while true
          if @jet_pattern[i] == '<'
            piece = move_left(piece)
            piece = move_right(piece) if !(piece & room).empty?
          else
            piece = move_right(piece)
            piece = move_left(piece) if !(piece & room).empty?
          end

          i = (i + 1) % @jet_pattern.size

          piece = move_down(piece)
          if !(piece & room).empty?
            piece = move_up(piece)
            room |= piece
            top = room.map { |_, y| y }.max

            # Try and find cycles to skip ahead
            sr = {i, t % 5, top_n_rows(room, 30)}
            if memo.has_key?(sr)
              prev_t, prev_y = memo[sr]
              dy = top - prev_y
              dt = t - prev_t
              f = (1000000000000_i64 - t) // dt
              skipped += f * dy
              t += f * dt
            end

            memo[sr] = {t, top}

            break
          end
        end

        t += 1
      end

      (top + skipped).to_s
    end

    private def get_piece(t : Int64, y : Int64) : Set(Position)
      case t
      when 0
        [{2_i64, y}, {3_i64, y}, {4_i64, y}, {5_i64, y}].to_set
      when 1
        [{3_i64, y + 2}, {2_i64, y + 1}, {3_i64, y + 1}, {4_i64, y + 1}, {3_i64, y}].to_set
      when 2
        [{2_i64, y}, {3_i64, y}, {4_i64, y}, {4_i64, y + 1}, {4_i64, y + 2}].to_set
      when 3
        [{2_i64, y}, {2_i64, y + 1}, {2_i64, y + 2}, {2_i64, y + 3}].to_set
      when 4
        [{2_i64, y + 1}, {2_i64, y}, {3_i64, y + 1}, {3_i64, y}].to_set
      else
        raise ArgumentError.new("t must be between 0 and 4")
      end
    end

    private def move_left(piece : Set(Position)) : Set(Position)
      return piece if piece.any? { |x, _| x == 0 }
      piece.map { |x, y| {x - 1, y} }.to_set
    end

    private def move_right(piece : Set(Position)) : Set(Position)
      return piece if piece.any? { |x, _| x == 6 }
      piece.map { |x, y| {x + 1, y} }.to_set
    end

    private def move_down(piece : Set(Position)) : Set(Position)
      piece.map { |x, y| {x, y - 1} }.to_set
    end

    private def move_up(piece : Set(Position)) : Set(Position)
      piece.map { |x, y| {x, y + 1} }.to_set
    end

    private def memo : Hash(Tuple(Int64, Int64, Set(Position)), Tuple(Int64, Int64))
      @memo ||= Hash(Tuple(Int64, Int64, Set(Position)), Tuple(Int64, Int64)).new
    end

    private def top_n_rows(room : Set(Position), n : Int64) : Set(Position)
      max_y = room.map { |_, y| y }.max
      room.select { |x, y| max_y - y <= n }.map { |x, y| {x, max_y - y} }.to_set
    end

    private def draw_room(room : Set(Position)) : String
      buf = ""

      max_y = room.map { |_, y| y }.max
      (1..max_y).reverse_each do |y|
        buf += "|"
        (0..6).each do |x|
          if room.includes?({x, y})
            buf += "#"
          else
            buf += "."
          end
        end
        buf += "|\n"
      end

      buf += "+-------+\n"

      buf
    end
  end
end
