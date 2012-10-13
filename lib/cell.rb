require File.expand_path("../point", __FILE__)

class Cell < Point

  def initialize(*args)
    if args.size == 1 && args[0].is_a?(Point)
      super(args[0].x, args[0].y)
    else
      super
    end
    self
  end

  def affect_area
    ((x-1)..(x+1)).map do |x_value|
      ((y-1)..(y+1)).map do |y_value|
        Point.new(x_value, y_value)
      end
    end.flatten.compact
  end
end

