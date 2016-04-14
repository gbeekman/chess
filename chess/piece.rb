class Piece
  BLACK = :black
  WHITE = :white

  attr_reader :color
  attr_accessor :pos
  def initialize(board, pos, color)
    @board = board
    @pos = pos
    @color = color
  end

  def moves
    raise "Go back. Danger lies here."
  end

  def valid_moves
    moves.reject { |move| move_into_check?(move) }
  end

  def move_into_check?(move)
    check_board = board.dup
    piece = check_board[pos]
    check_board[move] = piece
    check_board[pos] = nil
    piece.pos = move
    check_board.in_check?(color)
  end

  protected
  attr_reader :board
end
