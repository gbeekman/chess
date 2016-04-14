require_relative 'bishop'
require_relative 'pawn'
require_relative 'king'
require_relative 'knight'
require_relative 'rook'
require_relative 'queen'
require_relative 'piece'
require_relative 'errors'

class Board
  DIMENSIONS = 8
  POSITION_PIECE = [Rook, Knight, Bishop, Queen, King, Bishop, Knight, Rook]

  attr_reader :grid
  def initialize
    # a = Pawn.class
    # a[col].new
    @grid = populate
  end

  def [](pos)
    row, col = pos
    @grid[row][col]
  end

  def []=(pos, val)
    row, col = pos
    @grid[row][col] = val
  end

  def populate

    Array.new(8) do |row|
      Array.new(8) do |col|
        if row == 1 || row == 6
          color = row == 1 ? Piece::BLACK : Piece::WHITE
          Pawn.new(self, [row, col] , color)
        elsif row == 0 || row == 7
          color = row == 0 ? Piece::BLACK : Piece::WHITE
          piece_class = POSITION_PIECE[col]
          piece_class.new(self, [row, col] , color)
        else
          nil
        end
      end
    end
  end

  def in_bounds?(pos)
    row, col = pos
    row >= 0 && col >= 0 && row < grid.length && col < grid[row].length
  end

  def opposite_color(color)
    color == Piece::WHITE ? Piece::BLACK : Piece::WHITE
  end

  def get_pieces(color)
    pieces = []
    @grid.each do |row|
      row.each do |piece|
        next if piece.nil?
        pieces << piece if piece.color == color
      end
    end
    pieces
  end

  def find_king(color)
    get_pieces(color).select {|piece| piece.is_a?(King)}.first
  end

  def in_check?(color)
    king_pos = find_king(color).pos
    opponent_moves = get_pieces(opposite_color(color)).inject([]) {|acc, piece| acc + piece.moves}

    opponent_moves.include?(king_pos)
  end

  def checkmate?(color)
    moves = []
    king = find_king(color)
    pieces = get_pieces(color).each do |piece|
      moves += piece.moves
    end

    moves += king.valid_moves

    moves.all? do |position|
      check_board = dup
      piece = check_board[king.pos]
      check_board[position] = piece
      check_board[king.pos] = nil
      piece.pos = position
      check_board.in_check?(color)
    end && in_check?(color)
  end

  def move(start, end_pos)
    raise InvalidInput.new("No piece at position") if self[start].nil?
    raise InvalidInput.new("Esc to deselect") if start == end_pos

    piece = self[start]
    return false unless piece.valid_moves.include?(end_pos)

    self[end_pos] = piece
    self[start] = nil
    piece.pos = end_pos
    true
  end

  def dup
    new_board = Board.new

    DIMENSIONS.times do |row|
      DIMENSIONS.times do |col|
        piece = self[[row, col]]
        if piece.nil?
          new_board[[row, col]] = nil
        else
          new_board[[row, col]] = piece.class.new(new_board, piece.pos.dup, piece.color)
        end
      end
    end
    new_board
  end
end

if __FILE__ == $PROGRAM_NAME
  b = Board.new
  #p b.grid
  #b.move([0,0],[4,4])
  p b.grid
  #b.move([3,3],[1,1])
end
