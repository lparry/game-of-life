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
    expect(subject.cells.length).to eq(3)
  end

  it 'knows what points are worth looking at' do
    total_area =  [x.affect_area + y.affect_area + z.affect_area].flatten
    subject.surrounding_points.each do |point|
      expect(total_area).to include(point)
      expect(subject.cells).to_not include(point)
    end

    expect(subject.surrounding_points.count).to eq(15)
  end

  it "counts the living cells next to a point" do
    expect(subject.living_neighbours(Point(0,0))).to eq(0)
    expect(subject.living_neighbours(Point(0,2))).to eq(1)
    expect(subject.living_neighbours(Point(2,2))).to eq(2)
    expect(subject.living_neighbours(Point(1,2))).to eq(1)
  end

  it "should calculate population data once per turn" do
    expect(subject).to receive(:living_neighbours).at_least(1)
    subject.population_data
    expect(subject).to_not receive(:living_neighbours)
  end

  it "finds live cells with two live neighbors" do
    point = Point.new
    cell = Cell.new
    expect(subject.live_cell_with_two_live_neighbours(1, point)).to be_nil
    expect(subject.live_cell_with_two_live_neighbours(2, point)).to be_nil
    expect(subject.live_cell_with_two_live_neighbours(3, point)).to be_nil
    expect(subject.live_cell_with_two_live_neighbours(1, cell)).to be_nil
    expect(subject.live_cell_with_two_live_neighbours(3, cell)).to be_nil

    expect(subject.live_cell_with_two_live_neighbours(2, cell)).to eq(cell)
    expect(subject.live_cell_with_two_live_neighbours(2, cell)).to be_a(Cell)
  end

  it "finds cells with three live neighbors" do
    cell = Point.new
    expect(subject.point_with_three_live_neighbours(2, cell)).to be_nil
    expect(subject.point_with_three_live_neighbours(4, cell)).to be_nil

    expect(subject.point_with_three_live_neighbours(3, cell)).to eq(cell)
    expect(subject.point_with_three_live_neighbours(3, cell)).to be_a(Cell)
  end

  it "finds the live cells for the next tick" do
    expect(subject.live_cells_in_next_tick).to eq([Cell.new(1, 3), Cell.new(2, 3)])
  end

  it "gives a new world with the next tick of cells" do
    expect(subject.next_tick).to be_a(World)
    expect(subject.next_tick.cells).to eq([Cell.new(1, 3), Cell.new(2, 3)])
  end
end


# Any live cell with fewer than two live neighbours dies, as if caused by under-population.
# Any live cell with two or three live neighbours lives on to the next generation.
# Any live cell with more than three live neighbours dies, as if by overcrowding.
# Any dead cell with exactly three live neighbours becomes a live cell, as if by reproduction.
