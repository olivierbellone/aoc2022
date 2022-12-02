require "../spec_helper"

describe AoC2022::Day2 do
  it "solves part 1" do
    solver = AoC2022::Day2.new(File.read(File.join(__DIR__, "../fixtures/day2.txt")))
    solver.part1.should eq("15")
  end

  it "solves part 2" do
    solver = AoC2022::Day2.new(File.read(File.join(__DIR__, "../fixtures/day2.txt")))
    solver.part2.should eq("12")
  end
end
