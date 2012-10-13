require File.expand_path("../cell", __FILE__)
class World < Struct.new(:cells)
  def important_points
    cells.map(&:affect_area).flatten.uniq.sort
  end

  def living_neighbours(point)
    cells.count do |cell|
      cell.next_to?(point)
    end
  end


  def next_tick
    World.new(live_cells_in_next_tick)
  end

  def live_cells_in_next_tick
    live_cells_with_two_live_neighbours +
      cells_with_three_live_neighbours
  end

  def live_cells_with_two_live_neighbours
    cells.select do |cell|
      living_neighbours(cell) == 2
    end
  end

  def cells_with_three_live_neighbours
    important_points.map do |point|
      Cell.new(point) if living_neighbours(point) == 3
    end.compact
  end
end



