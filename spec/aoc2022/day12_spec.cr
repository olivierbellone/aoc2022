require "../spec_helper"

describe AoC2022::Day12 do
  it "solves part 1" do
    solver = AoC2022::Day12.new(File.read(File.join(__DIR__, "../fixtures/day12.txt")))
    solver.part1.should eq("31")
  end

  it "solves part 2" do
    solver = AoC2022::Day12.new(File.read(File.join(__DIR__, "../fixtures/day12.txt")))
    solver.part2.should eq("29")
  end
end
