require_relative 'board'
require_relative 'piece'
require 'colorize'
require 'io/console'

class Display
  COLORS = {
    light: :light_black,
    dark: :yellow,
    cursor: :magenta,
    selection: :green,
    black: :black,
    white: :light_white,
    check: :red,
    possible_move: :blue
  }

  def initialize(board)
    @board = board
  end

  def string_space(pos, selection = nil, cursor = nil)
    row, col = pos
    piece = @board[pos]

    light = COLORS[:light]
    dark = COLORS[:dark]
    output = piece.nil? ? '  ' : "#{piece} "
    color = {}

    color[:background] = COLORS[:cursor] if cursor == pos
    color[:background] = COLORS[:selection] if selection == pos

    if color[:background].nil?
      if row.even?
        color[:background] = col.odd? ? COLORS[:light] : COLORS[:dark]
      else
        color[:background] = col.even? ? COLORS[:light] : COLORS[:dark]
      end
    end

    unless piece.nil?
      color[:color] = Piece::BLACK == piece.color ? COLORS[:black] : COLORS[:white]
    end

    if piece.is_a?(King) && @board.in_check?(piece.color)
      color[:background] = COLORS[:check]
    end

    unless selection.nil?
      moves = @board[selection].valid_moves
      color[:background] = COLORS[:possible_move] if moves.include?(pos)
      color[:background] = COLORS[:cursor] if cursor == pos
    end

    output.colorize(color)
  end

  def render(selection = nil, cursor = nil)
    system('clear')
    Board::DIMENSIONS.times do |row|
      puts
      Board::DIMENSIONS.times do |col|
        output = string_space([row,col], selection, cursor)
        print output
      end
    end
    puts
  end
end
