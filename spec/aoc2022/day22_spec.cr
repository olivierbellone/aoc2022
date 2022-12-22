require "../spec_helper"

describe AoC2022::Day22 do
  it "solves part 1" do
    solver = AoC2022::Day22.new(File.read(File.join(__DIR__, "../fixtures/day22.txt")))
    solver.part1.should eq("6032")
  end

  it "solves part 2" do
    solver = AoC2022::Day22.new(File.read(File.join(__DIR__, "../fixtures/day22.txt")))
    # solver.part2.should eq("5031")
  end
end
