require "./snake"

class Game
  def initialize
    @score = 0
    @ball_x = rand()
    @ball_y = rand()
  end

  def draw
    Square.new(
      x: @ball_x * GRID_SIZE,
      y: @ball_y * GRID_SIZE,
      size: GRID_SIZE,
      color: "yellow"
    )
  end
end

snake = Snake.new
game = Game.new

update do
  clear

  snake.move
  snake.draw
  game.draw
end

on :key_down do |event|
  if %w[up down right left].include?(event.key)
    snake.direction = event.key if snake.can_change_direction_to(event.key)
  end
end

show
