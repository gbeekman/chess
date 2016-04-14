require_relative 'piece'

class Pawn < Piece
  CAPTURE_DIRECTIONS = [1, -1]

  def initialize(board, pos, color)
    super(board, pos, color)
    @starting_pos = pos.dup
  end

  def moves
    row_direction = Piece::BLACK == color ? 1 : -1

    results = []

    # Check start 2
    row, col = pos
    if @starting_pos == pos
      check_pos = [row + row_direction * 2, col]
      check_front = [row + row_direction, col]
      results << check_pos if board[check_pos].nil? && board[check_front].nil?
    end

    # Check diagonal captures
    CAPTURE_DIRECTIONS.each do |direction|
      check_pos = [row + row_direction, col + direction]
      next unless board.in_bounds?(check_pos)
      next if board[check_pos].nil?
      results << check_pos if board[check_pos].color != color
    end

    # Normal move
    check_pos = [row + row_direction, col]
    results << check_pos if board.in_bounds?(check_pos) && board[check_pos].nil?

    results
  end

  def to_s
    "♟"
  end
end
