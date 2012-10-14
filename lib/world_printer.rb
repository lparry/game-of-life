require File.expand_path("../world", __FILE__)
require 'forwardable'

class WorldPrinter

  extend Forwardable

  def_delegators :@viewport, :move_left, :move_right, :move_up, :move_down, :zoom_in, :zoom_out, :visible_pixels

  def initialize(viewport)
    @viewport = viewport
  end

  def render(world)
    @viewport.row_range.map{|row| render_row(world, row) }
  end

  def render_row(world, y)
    @viewport.column_range.map do |x|
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
