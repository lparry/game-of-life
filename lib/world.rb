require File.expand_path("../cell", __FILE__)
class World < Struct.new(:cells)
  def important_points
    cells.map(&:affect_area).flatten.uniq.sort
  end
end
