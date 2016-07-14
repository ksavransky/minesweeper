thbrequire_relative "tile"

class Board
  attr_reader :grid

  def initialize(grid = Array.new(9) { Array.new(9) })
    @grid = grid
  end

  def populate
    @grid.each_index do |row|
      row.each_index do |col|
        @grid[row][col] = Tile.new
      end
    end
  end

  def bomb_placer
    rand_pos = [rand(grid.length), rand(grid.length)]
    self[pos] = Tile.new("B")
  end

  def [](pos)
    row, col = pos
    @grid[row][col]
  end

  def []= (pos, value)
    row, col = pos
    @grid[row][col] = value
  end
end
