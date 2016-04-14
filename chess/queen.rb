require_relative 'sliding'

class Queen < SlidingPiece
  def move_dirs
    SlidingPiece::DIRECTIONS[:straight] + SlidingPiece::DIRECTIONS[:diagonal]
  end

  def to_s
    "♛"
  end
end
