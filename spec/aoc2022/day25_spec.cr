require "../spec_helper"

describe AoC2022::Day25 do
  it "solves part 1" do
    solver = AoC2022::Day25.new(File.read(File.join(__DIR__, "../fixtures/day25.txt")))
    solver.part1.should eq("2=-1=0")
  end

  it "solves part 2" do
    solver = AoC2022::Day25.new(File.read(File.join(__DIR__, "../fixtures/day25.txt")))
    solver.part2.should eq("")
  end
end
