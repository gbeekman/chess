require_relative 'display'
require_relative 'board'
require_relative 'piece'
require_relative 'human_player'
class Game

  def initialize(board, white, black)
    @board = board
    @current_player = white
    @next_player = black
  end

  def play_turn

    done = false
    until done
      move = current_player.get_input
      next if move.nil? || move.any? { |el| el.nil? }
      done = board.move(move[0],move[1])
    end
  end

  def switch_turn
    self.current_player, self.next_player = next_player, current_player
  end

  def play

    until board.checkmate?(Piece::WHITE) || board.checkmate?(Piece::BLACK)
      play_turn
      switch_turn
    end

    puts "Player #{next_player.name} has won!"
  end

  private
  attr_accessor :current_player, :next_player
  attr_reader :board

end



if __FILE__ == $PROGRAM_NAME
  b = Board.new()
  white = HumanPlayer.new("One", Display.new(b), b, Piece::WHITE)
  black = HumanPlayer.new("Two", Display.new(b), b, Piece::BLACK)
  g = Game.new(b, white, black)
  g.play
end
