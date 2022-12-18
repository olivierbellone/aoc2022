require "../spec_helper"

describe AoC2022::Day18 do
  it "solves part 1" do
    solver = AoC2022::Day18.new(File.read(File.join(__DIR__, "../fixtures/day18.txt")))
    solver.part1.should eq("64")
  end

  it "solves part 2" do
    solver = AoC2022::Day18.new(File.read(File.join(__DIR__, "../fixtures/day18.txt")))
    solver.part2.should eq("58")
  end
end
