require_relative 'sliding'

class Bishop < SlidingPiece
  def move_dirs
    SlidingPiece::DIRECTIONS[:diagonal]
  end

  def to_s
    "♝"
  end
end
