require_relative 'display'
require_relative 'cursor'
require 'io/console'

class HumanPlayer
  include Cursor

  attr_reader :name, :color

  def initialize(name, display, board, color)
    @name = name
    @display = display
    @board = board
    @color = color
    @cursor = [0, 0]
    @selection = nil
  end

  def get_input
    display.render(selection, cursor)
    puts "#{name}'s Turn!"
    key = KEYMAP[read_char]
    pos = handle_key(key)
    pos
  end

  private
  attr_accessor :selection, :cursor
  attr_reader :board, :display
end
