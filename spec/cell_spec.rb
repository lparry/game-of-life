require File.expand_path('../../lib/cell', __FILE__)

describe Cell do
  it "can be created from coordinates" do
    cell = Cell.new(1,5)
    cell.x.should == 1
    cell.y.should == 5
  end

  it "can be created from a Point" do
    cell = Cell.new(Point(1,5))
    cell.x.should == 1
    cell.y.should == 5
  end

  it "can be created from a Cell" do
    cell = Cell.new(Cell.new(1,5))
    cell.x.should == 1
    cell.y.should == 5
  end

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

end

