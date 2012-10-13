require File.expand_path('../../lib/world',__FILE__)

describe World do

  # 0123
  #0
  #1---
  #2-x--
  #3--y-
  #4-x--
  #5---

  let(:x) { Cell.new(1,2) }
  let(:y) { Cell.new(2,3) }
  let(:z) { Cell.new(1,4) }
  subject {World.new [x, y, z]}

  it 'has many cells' do
    subject.cells.length.should == 3
  end

  it 'knows what points are worth looking at' do
    [x.affect_area + y.affect_area + z.affect_area].flatten.each do |point|
      subject.important_points.should include(point)
    end

    subject.important_points.count.should == 18
  end

  it "counts the living cells next to a point" do
    subject.living_neighbours(Point(0,0)).should == 0
    subject.living_neighbours(Point(0,2)).should == 1
    subject.living_neighbours(Point(2,2)).should == 2
    subject.living_neighbours(Point(1,2)).should == 1
  end

  it "finds live cells with two live neighbors" do
    subject.live_cells_with_two_live_neighbours.should == [Cell.new(2, 3)]
  end

  it "finds cells with three live neighbors" do
    subject.cells_with_three_live_neighbours.should == [Cell.new(1, 3)]
  end

  it "finds the live cells for the next tick" do
    subject.live_cells_in_next_tick.should == [Cell.new(2, 3), Cell.new(1, 3)]
  end

  it "gives a new world with the next tick of cells" do
    subject.next_tick.should be_a(World)
    subject.next_tick.cells.should == [Cell.new(2, 3), Cell.new(1, 3)]
  end
end


# Any live cell with fewer than two live neighbours dies, as if caused by under-population.
# Any live cell with two or three live neighbours lives on to the next generation.
# Any live cell with more than three live neighbours dies, as if by overcrowding.
# Any dead cell with exactly three live neighbours becomes a live cell, as if by reproduction.
