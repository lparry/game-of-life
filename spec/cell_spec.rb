require File.expand_path('../../lib/cell', __FILE__)

describe Cell do
  it "should know its neighbors" do
    cell = Cell.new(2, 2)

    cell.affect_area.should == [
      Point(1,1),
      Point(1,2),
      Point(1,3),
      Point(2,1),
      Point(2,2),
      Point(2,3),
      Point(3,1),
      Point(3,2),
      Point(3,3)
    ]
  end

  it "should know if its the same Cell" do
    Cell.new(1, 2, :alive).should == Cell.new(1, 2)

    Cell.new(1,2).should_not == Cell.new(1,3)
  end

  it "should know if it's alive?" do
    Cell.new(1, 2, false).should_not be_alive
    Cell.new(1, 2, true).should be_alive
    cell = Cell.new(1, 2)
    cell.alive = true
    cell.should be_alive
  end

end

