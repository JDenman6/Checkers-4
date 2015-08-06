require_relative 'board'

class Piece

  RED_DELTAS = [[-1, -1], [-1, 1]]
  BLACK_DELTAS = [[1, -1], [1, 1]]

  attr_accessor :pos, :color, :grid

  def initialize(pos, color, grid)
    @color, @pos, @grid = color, pos, grid
    self.grid
  end

  def to_s
    "#{self.color}"
  end

  def move(to_pos)

    if grid.on_board?(to_pos)
      if slide_moves.include?(to_pos)
        slide_move(to_pos)
      elsif jump_moves.include?(to_pos)
        jump_move(to_pos)
      else
        raise "ERROR! can't move there."
      end
    else
      raise "ERROR! in move"
    end

    nil
  end

  def slide_move(to_pos)
    if grid[to_pos].nil?
      grid.move!(self.pos,to_pos)
    else
      raise "ERROR! in slide move"
    end

    nil
  end

  def jump_move(to_pos)
    if grid.on_board?(to_pos)
      grid.move!(self.pos, to_pos)
    else
      raise "ERROR! Can't jump there."
    end
  end

  def deltas
    (self.color == :r) ? RED_DELTAS : BLACK_DELTAS
  end

  def slide_moves
    possible_moves = []
    row, col = self.pos
    deltas.each do |delta|
      row_delta, col_delta = delta
      move = [row + row_delta, col + col_delta]

      possible_moves << move if self.grid[move].nil?
    end

    possible_moves
  end

  def jump_moves
    possible_jumps = []
    row, col = self.pos
    deltas.each do |delta|
      row_delta, col_delta = delta
      possible_jumps << [row + (2 * row_delta), col + (2 * col_delta)]
    end

    possible_jumps
  end



end


if __FILE__ == $PROGRAM_NAME

    board = Board.new

    board.add_piece([2,2], :r)
    board.add_piece([1,3], :b)
    board.render

    board[[2,2]].move([0,4])

    board.render

end
