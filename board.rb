require_relative "tile"
require 'byebug'

class Board
  attr_reader :grid

  def initialize(grid = Array.new(9) { Array.new(9)})
    @grid = grid
  end

  def populate
    15.times {bomb_placer}
    @grid.each_with_index do |row, idx1|
      row.each_index do |col|
        pos = [idx1,col]
        unless @grid[idx1][col].is_a?(Tile)
          @grid[idx1][col] = Tile.new(bomb_counter(pos))
        end
      end
    end
  end

  def bomb_counter(pos)
    bombs = 0
    x, y = pos
    surrounding = [[x-1, y+1], [x, y+1], [x+1, y+1], [x-1, y], [x+1, y],
    [x-1, y-1],[x, y-1], [x+1, y-1]]
    surrounding.each do |position|
      if position[0].between?(0,8)
        bombs += 1 if self[position] != nil && self[position].value == "B"
      end
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

  def render
    @grid.each_with_index do |row, idx|
      row.each_index do |col|
        pos = [idx,col]
        if self[pos].flagged
          print "F"
        elsif !self[pos].revealed
          print "X"
        else
          print self[pos].value
        end
      end
      print "\n"
    end
  end

  def cheat_render
    @grid.each_with_index do |row, idx|
      row.each_index do |col|
        pos = [idx,col]
        print self[pos].value
      end
      print "\n"
    end
  end

  def reveal(pos, visited = [])
    self[pos].revealed = true
    visited << pos

    x, y = pos

    surrounding = [[x-1, y+1], [x, y+1], [x+1, y+1], [x-1, y], [x+1, y],
    [x-1, y-1],[x, y-1], [x+1, y-1]]

    if self[pos].value == "0".to_i
      surrounding.each do |position|
        if position[0].between?(0,8) && position[1].between?(0,8) && !visited.include?(position)
          self.reveal(position, visited)
        end
      end
    end

  end


end
