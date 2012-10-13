require File.expand_path("../point", __FILE__)

class Cell
  attr_accessor :point, :alive
  alias :alive? :alive

  def initialize(x, y, alive = false)
    @point = Point(x, y)
    @alive = !!alive
  end

  def next_to?(other)
    point.next_to? other.point
  end

  def ==(other)
    point == other.point
  end

  def <=>(other)
    point <=> other.point
  end

  def affect_area
    ((point.x-1)..(point.x+1)).map do |x_value|
      ((point.y-1)..(point.y+1)).map do |y_value|
        Point.new(x_value, y_value) 
      end
    end.flatten.compact
  end
end

