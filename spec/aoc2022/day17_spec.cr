require "../spec_helper"

describe AoC2022::Day17 do
  it "solves part 1" do
    solver = AoC2022::Day17.new(File.read(File.join(__DIR__, "../fixtures/day17.txt")))
    solver.part1.should eq("3068")
  end

  it "solves part 2" do
    solver = AoC2022::Day17.new(File.read(File.join(__DIR__, "../fixtures/day17.txt")))
    solver.part2.should eq("1514285714288")
  end
end
