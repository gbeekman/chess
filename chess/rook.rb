require_relative 'sliding'

class Rook < SlidingPiece
  def move_dirs
    SlidingPiece::DIRECTIONS[:straight]
  end

  def to_s
    "♜"
  end
end
