require "../spec_helper"

describe AoC2022::Day1 do
  it "solves part 1" do
    solver = AoC2022::Day1.new(File.read(File.join(__DIR__, "../fixtures/day1.txt")))
    solver.part1.should eq("24000")
  end

  it "solves part 2" do
    solver = AoC2022::Day1.new(File.read(File.join(__DIR__, "../fixtures/day1.txt")))
    solver.part2.should eq("45000")
  end
end
