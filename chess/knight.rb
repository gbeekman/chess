require_relative 'stepping'
class Knight < SteppingPiece
  MOVES = [
    [-2, -1],
    [-2,  1],
    [-1, -2],
    [-1,  2],
    [ 1, -2],
    [ 1,  2],
    [ 2, -1],
    [ 2,  1]
  ]
  def moves
    results = []

    MOVES.each do |direction|
      row = direction[0] + pos[0]
      col = direction[1] + pos[1]
      next unless board.in_bounds?([row,col])
      next if !board[[row, col]].nil? && board[[row, col]].color == color
      results << [row,col]
    end
    results
  end

  def to_s
    "♞"
  end
end
