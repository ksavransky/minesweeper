require_relative "tile"

class Board
  attr_reader :grid

  def initialize(grid = Array.new(9) { Array.new(9) })
    @grid = grid
  end

  def populate
    15.times {bomb_placer}
  end

  def bomb_counter(pos)
    bombs = 0
    x, y = pos
    surrounding = [[x-1, y+1], [x, y+1], [x+1, y+1], [x-1, y], [x+1, y],
    [x-1, y-1],[x, y-1], [x+1, y-1]]
    surrounding.each do |position|
      bombs += 1 if self[position].value == "B"
    end
    bombs
  end

  def bomb_placer
    rand_pos = [rand(grid.length), rand(grid.length)]
    self[rand_pos] = Tile.new("B")
  end

  def [](pos)
    row, col = pos
    @grid[row][col]
  end

  def []= (pos, value)
    row, col = pos
    @grid[row][col] = value
  end

  # def render
  #   @grid.each do |row|
  #     p row.map { |el| el.value }.join(" ")
  #   end
  # end
end

# board = Board.new
# board.populate
# board.render
