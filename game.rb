require_relative "board"

class Game
  def initialize(board)
    @board = board
  end

  def play_turn
    puts "Pick a spot"
    input = gets.chomp
  end

  def play
    until won?
      play_turn
    end
  end

  def won?
    @board.grid.flatten.reject {|el| el.revealed}.all? { |el| el.value == "B"}
  end
end
