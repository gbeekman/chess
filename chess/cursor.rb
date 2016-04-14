module Cursor
  KEYMAP = {
    "\e" => :escape,
    "\r" => :return,
    "\e[A" => :up,
    "\e[B" => :down,
    "\e[C" => :right,
    "\e[D" => :left,
    "\u0003" => :ctrl_c,
  }

  MOVES = {
    left: [0, -1],
    right: [0, 1],
    up: [-1, 0],
    down: [1, 0]
  }

  def update_pos(diff)
    new_pos = [cursor[0] + diff[0], cursor[1] + diff[1]]
    self.cursor = new_pos if board.in_bounds?(new_pos)
  end

  def handle_key(key)
    case key
    when :ctrl_c
      exit 0
    when :escape
      self.selection = nil
      nil
    when :return
      if cursor == selection
        self.selection = nil
        nil
      elsif selection.nil?
        piece = board[cursor]
        self.selection = cursor if !piece.nil? && color == piece.color
        nil
      else
        result = [selection.dup, cursor]
        self.selection = nil
        result
      end
    when :left, :right, :up, :down
      update_pos(MOVES[key])
      nil
    end
  end

  def read_char
    STDIN.echo = false
    STDIN.raw!

    input = STDIN.getc.chr
    if input == "\e" then
      input << STDIN.read_nonblock(3) rescue nil
      input << STDIN.read_nonblock(2) rescue nil
    end
  ensure
    STDIN.echo = true
    STDIN.cooked!

    return input
  end

end
