require File.expand_path("../world", __FILE__)
class WorldPrinter

  attr_accessor :start_x, :start_y, :width, :height

  def initialize(start_x, start_y, width, height)
    @start_x, @start_y, @width, @height = start_x, start_y, width, height
  end

  def row_range
    (start_y...(start_y + height))
  end

  def column_range
    (start_x...(start_x + width))
  end

  def render(world)
    row_range.map{|row| render_row(world, row) }
  end

  def render_row(world, y)
    column_range.map do |x|
      world.cells.include?(Point(x, y))
    end
  end

  def print(world)
    render(world).map do |line|
      line.map do |char|
        char ? "x" : " "
      end.join
    end.join("\n")
  end
end
