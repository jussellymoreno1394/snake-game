require "ruby2d"

set background: "#F56991"
set fps_cap: 20

GRID_SIZE = 15
GRID_WIDTH = Window.width / GRID_SIZE
GRID_HEIGHT = Window.height / GRID_SIZE

class Snake
  attr_writer :direction

  def initialize
    @positions = [[1, 0], [1, 1], [1, 2], [1, 3], [1, 4]]
    @direction = "down"
    @growing = false
  end

  def draw
    @positions.each do |position|
      Square.new(
        x: position[0] * GRID_SIZE,
        y: position[1] * GRID_SIZE,
        size: GRID_SIZE - 1,
        color: "#FFE5B4"
      )
    end
  end

  def move
    @positions.shift if !@growing
    case @direction
    when "down"
      @positions.push(new_coords(head[0], head[1] + 1))
    when "up"
      @positions.push(new_coords(head[0], head[1] - 1))
    when "left"
      @positions.push(new_coords(head[0] - 1, head[1]))
    when "right"
      @positions.push(new_coords(head[0] + 1, head[1]))
    end
    @growing = false
  end

  def new_coords(x, y)
    [x % GRID_WIDTH, y % GRID_HEIGHT]
  end

  def can_change_direction_to(new_direction)
    case @direction
    when "down"
      new_direction != "up"
    when "up"
      new_direction != "down"
    when "left"
      new_direction != "right"
    when "right"
      new_direction != "left"
    end
  end

  def x_position
    head[0]
  end

  def y_position
    head[1]
  end

  def grow
    @growing = true
  end

  def hit_itself
    @positions.uniq.length != @positions.length
  end

  private

  def head
    @positions.last
  end
end
