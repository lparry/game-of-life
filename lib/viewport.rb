class Viewport

  def initialize(start_x, start_y, width, height)
    @start_x, @start_y, @width, @height = start_x, start_y, width, height
  end

  def move_left
    @start_x -= 1
  end

  def move_right
    @start_x += 1
  end

  def move_up
    @start_y -= 1
  end

  def move_down
    @start_y += 1
  end

  def zoom_in
    @start_x -= 1
    @start_y -= 1
    @width  += 2
    @height += 2
  end

  def zoom_out
    @start_x += 1
    @start_y += 1
    @width  -= 2
    @height -= 2
  end

  def row_range
    (@start_y...(@start_y + @height))
  end

  def column_range
    (@start_x...(@start_x + @width))
  end

  def visible_pixels
    column_range.to_a.product(row_range.to_a)
  end
end
