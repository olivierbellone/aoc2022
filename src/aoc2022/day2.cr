require "./solver"

module AoC2022
  class Day2 < Solver
    MOVES_CORES = {
      'X' => 1, # Rock is worth 1 point
      'Y' => 2, # Paper is worth 2 points
      'Z' => 3, # Scissors is worth 3 points
    }

    OUTCOME_SCORES = {
      'X' => 0, # A loss is worth 0 points
      'Y' => 3, # A draw is worth 3 points
      'Z' => 6, # A win is worth 6 points
    }

    PART_1_OUTCOMES = {
      {'A', 'X'} => 'Y', # Rock / Rock: draw
      {'B', 'X'} => 'X', # Paper / Rock: loss
      {'C', 'X'} => 'Z', # Scissors / Rock: win
      {'A', 'Y'} => 'Z', # Rock / Paper: win
      {'B', 'Y'} => 'Y', # Paper / Paper: draw
      {'C', 'Y'} => 'X', # Scissors / Paper: loss
      {'A', 'Z'} => 'X', # Rock / Scissors: loss
      {'B', 'Z'} => 'Z', # Paper / Scissors: win
      {'C', 'Z'} => 'Y', # Scissors / Scissors: draw
    }

    PART_2_MOVES = {
      {'A', 'X'} => 'Z', # Rock / loss: Scissors
      {'B', 'X'} => 'X', # Paper / loss: Rock
      {'C', 'X'} => 'Y', # Scissors / loss: Paper
      {'A', 'Y'} => 'X', # Rock / draw: Rock
      {'B', 'Y'} => 'Y', # Paper / draw: Paper
      {'C', 'Y'} => 'Z', # Scissors / draw: Scissors
      {'A', 'Z'} => 'Y', # Rock / win: Paper
      {'B', 'Z'} => 'Z', # Paper / win: Scissors
      {'C', 'Z'} => 'X', # Scissors / win: Rock
    }

    property guide : Array(Tuple(Char, Char))

    def initialize(input : String)
      @guide = input
        .strip("\n")
        .split("\n")
        .map do |line|
          arr = line.split(" ")
          { arr[0][0], arr[1][0] }
        end
    end

    def part1 : String
      guide.map { |moves| OUTCOME_SCORES[PART_1_OUTCOMES[moves]] + MOVES_CORES[moves[1]] }.sum.to_s
    end

    def part2 : String
      guide.map { |moves| OUTCOME_SCORES[moves[1]] + MOVES_CORES[PART_2_MOVES[moves]] }.sum.to_s
    end
  end
end
