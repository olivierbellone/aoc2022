require "../spec_helper"

describe AoC2022::Day10 do
  it "solves part 1" do
    solver = AoC2022::Day10.new(File.read(File.join(__DIR__, "../fixtures/day10.txt")))
    solver.part1.should eq("13140")
  end

  it "solves part 2" do
    solver = AoC2022::Day10.new(File.read(File.join(__DIR__, "../fixtures/day10.txt")))
    solver.part2.should eq(<<-IMG
##..##..##..##..##..##..##..##..##..##..
###...###...###...###...###...###...###.
####....####....####....####....####....
#####.....#####.....#####.....#####.....
######......######......######......####
#######.......#######.......#######.....
IMG
    )
  end
end
