
class Turn
  attr_reader :points
  attr_reader :previous_turn
end


class World < Struct.new(:cells)
  def important_points
    cells.map(&:affect_area).flatten
  end
end

