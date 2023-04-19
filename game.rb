require "./snake"

class Game
  def initialize
    @score = 0
    @finished = false
    @ball_x = rand(GRID_WIDTH)
    @ball_y = rand(GRID_HEIGHT)
  end

  def draw
    unless finished
      Square.new(
        x: @ball_x * GRID_SIZE,
        y: @ball_y * GRID_SIZE,
        size: GRID_SIZE,
        color: "yellow"
      )
    end
    Text.new(message, color: "green", x: 10, y: 10, size: 20)
  end

  def snake_hit_ball(x, y)
    @ball_x == x && @ball_y == y
  end

  def record_hit
    @score += 1
    @ball_x = rand(GRID_WIDTH)
    @ball_y = rand(GRID_HEIGHT)
  end

  def finish
    @finished = true
  end

  def finished
    @finished
  end

  private

  def message
    if finished
      "Game over, your score was: #{@score}, press 'R' to restart."
    else
      "Score: #{@score}"
    end
  end
end

snake = Snake.new
game = Game.new

update do
  clear

  snake.move unless game.finished

  snake.draw
  game.draw

  if game.snake_hit_ball(snake.x_position, snake.y_position)
    game.record_hit
    snake.grow
  end

  game.finish if snake.hit_itself
end

on :key_down do |event|
  if %w[up down right left].include?(event.key)
    snake.direction = event.key if snake.can_change_direction_to(event.key)
  end
  if event.key == "r"
    snake = Snake.new
    game = Game.new
  end
end

show
