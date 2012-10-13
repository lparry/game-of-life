require File.expand_path("../cell", __FILE__)
class World < Struct.new(:cells)
  def surrounding_points
    cells.map(&:affect_area).flatten.uniq.reject{|point| cells.any?{|cell| cell == point }}
  end

  def population_data
    @population_data ||= (surrounding_points + cells).map do |point|
      [living_neighbours(point), point]
    end
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
    population_data.map do |data|
        point_with_three_live_neighbours(*data) || live_cell_with_two_live_neighbours(*data)
    end.compact
  end

  def live_cell_with_two_live_neighbours(neighbours, point)
    point if neighbours == 2 && point.is_a?(Cell)
  end

  def point_with_three_live_neighbours(neighbours, point)
    Cell.new(point) if neighbours == 3
  end

end



