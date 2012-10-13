class Point < Struct.new(:x, :y)
  def next_to?(other)
    (other.x - x).abs <= 1 && (other.y - y).abs <= 1
  end

  def ==(other)
    x == other.x && y == other.y
  end

  def <=>(other)
    x_diff = x <=> other.x
    y_diff = y <=> other.y

    if (x_diff == 0 && y_diff == 0)
      0
    elsif y_diff != 0
      y_diff
    else
      x_diff
    end
  end
end

def Point(*args)
  Point.new(*args)
end
