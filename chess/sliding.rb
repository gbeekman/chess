require_relative 'piece'

class SlidingPiece < Piece
  DIRECTIONS = {
    :diagonal => [[-1,1], [-1,-1], [1,1], [1,-1]],
    :straight => [[1,0],[-1,0],[0,1],[0,-1]]
  }

  def moves_direction(direction)
    row, col = pos

    results = []
    row += direction[0]
    col += direction[1]
    while board.in_bounds?([row, col])
      piece = board[[row, col]]
      unless piece.nil?
        results << [row, col] if piece.color != self.color
        break
      end
      results << [row, col]
      row += direction[0]
      col += direction[1]
    end

    results
  end

  def moves
    directions = move_dirs
    options = []

    directions.each do |direction|
      options += moves_direction(direction)
    end

    options
  end

  # Returns [[],[]]
  def move_dirs
    raise "Don't call here."
  end
end
