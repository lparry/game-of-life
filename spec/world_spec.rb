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
    total_area =  [x.affect_area + y.affect_area + z.affect_area].flatten
    subject.surrounding_points.each do |point|
      total_area.should include(point)
      subject.cells.should_not include(point)
    end

    subject.surrounding_points.count.should == 15
  end

  it "counts the living cells next to a point" do
    subject.living_neighbours(Point(0,0)).should == 0
    subject.living_neighbours(Point(0,2)).should == 1
    subject.living_neighbours(Point(2,2)).should == 2
    subject.living_neighbours(Point(1,2)).should == 1
  end

  it "should calculate population data once per turn" do
    subject.should_receive(:living_neighbours).at_least(1)
    subject.population_data
    subject.should_not_receive(:living_neighbours)
  end

  it "finds live cells with two live neighbors" do
    point = Point.new
    cell = Cell.new
    subject.live_cell_with_two_live_neighbours(1, point).should be_nil
    subject.live_cell_with_two_live_neighbours(2, point).should be_nil
    subject.live_cell_with_two_live_neighbours(3, point).should be_nil
    subject.live_cell_with_two_live_neighbours(1, cell).should be_nil
    subject.live_cell_with_two_live_neighbours(3, cell).should be_nil

    subject.live_cell_with_two_live_neighbours(2, cell).should == cell
    subject.live_cell_with_two_live_neighbours(2, cell).should be_a(Cell)
  end

  it "finds cells with three live neighbors" do
    cell = Point.new
    subject.point_with_three_live_neighbours(2, cell).should be_nil
    subject.point_with_three_live_neighbours(4, cell).should be_nil

    subject.point_with_three_live_neighbours(3, cell).should == cell
    subject.point_with_three_live_neighbours(3, cell).should be_a(Cell)
  end

  it "finds the live cells for the next tick" do
    subject.live_cells_in_next_tick.should == [Cell.new(1, 3), Cell.new(2, 3)]
  end

  it "gives a new world with the next tick of cells" do
    subject.next_tick.should be_a(World)
    subject.next_tick.cells.should == [Cell.new(1, 3), Cell.new(2, 3)]
  end
end


# Any live cell with fewer than two live neighbours dies, as if caused by under-population.
# Any live cell with two or three live neighbours lives on to the next generation.
# Any live cell with more than three live neighbours dies, as if by overcrowding.
# Any dead cell with exactly three live neighbours becomes a live cell, as if by reproduction.
