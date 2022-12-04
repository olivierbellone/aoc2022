require "../spec_helper"

describe AoC2022::Day4 do
  it "solves part 1" do
    solver = AoC2022::Day4.new(File.read(File.join(__DIR__, "../fixtures/day4.txt")))
    solver.part1.should eq("2")
  end

  it "solves part 2" do
    solver = AoC2022::Day4.new(File.read(File.join(__DIR__, "../fixtures/day4.txt")))
    solver.part2.should eq("4")
  end
end
