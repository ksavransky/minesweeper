require_relative "board"

class Game
  def initialize(board)
    @board = board
  end

  def play_turn
    @board.cheat_render
    print "\n"
    print "\n"
    @board.render

    puts "Do you want to flag a spot? (y/n)"
    first_input = gets.chomp

    puts "Pick a spot."
    second_input = gets.chomp.split(",").map { |el| Integer(el) }

    if first_input == "y"
      @board[second_input].flagged = true
    else
      if @board[second_input].value == "B"
        @board[second_input].revealed = true
        @board.render
        abort("YOU LOSE")
      else
        @board.reveal(second_input)
      end
    end
  end


  def play
    @board.populate
    until won?
      play_turn
    end
  end

  def won?
    @board.grid.flatten.reject {|el| el.revealed}.all? { |el| el.value == "B"}
  end
end

game = Game.new(Board.new)
game.play
