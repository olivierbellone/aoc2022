require "../spec_helper"

describe AoC2022::Day13 do
  it "solves part 1" do
    solver = AoC2022::Day13.new(File.read(File.join(__DIR__, "../fixtures/day13.txt")))
    solver.part1.should eq("13")
  end

  it "solves part 2" do
    solver = AoC2022::Day13.new(File.read(File.join(__DIR__, "../fixtures/day13.txt")))
    solver.part2.should eq("140")
  end
end
