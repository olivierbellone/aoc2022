require "../spec_helper"

describe AoC2022::Day20 do
  it "solves part 1" do
    solver = AoC2022::Day20.new(File.read(File.join(__DIR__, "../fixtures/day20.txt")))
    solver.part1.should eq("3")
  end

  it "solves part 2" do
    solver = AoC2022::Day20.new(File.read(File.join(__DIR__, "../fixtures/day20.txt")))
    solver.part2.should eq("1623178306")
  end
end
