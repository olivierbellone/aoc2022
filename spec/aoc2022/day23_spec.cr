require "../spec_helper"

describe AoC2022::Day23 do
  it "solves part 1" do
    solver = AoC2022::Day23.new(File.read(File.join(__DIR__, "../fixtures/day23.txt")))
    solver.part1.should eq("110")
  end

  it "solves part 2" do
    solver = AoC2022::Day23.new(File.read(File.join(__DIR__, "../fixtures/day23.txt")))
    solver.part2.should eq("20")
  end
end
