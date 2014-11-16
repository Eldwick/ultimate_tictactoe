class Board < ActiveRecord::Base
  has_many :miniboards
  def self.initialize_board
    main_board = Board.create
    miniboards = Miniboard.initialize_array
    main_board.miniboards << miniboards
    return main_board 
  end

  def complete_tree
    top_row_miniboards = []
    middle_row_miniboards = []
    bottom_row_miniboards = []
    top_row.each do |miniboard|
      top_row_miniboards << miniboard.tree
    end
    middle_row.each do |miniboard|
      middle_row_miniboards << miniboard.tree
    end
    bottom_row.each do |miniboard|
      bottom_row_miniboards << miniboard.tree
    end
    return {
      grid: [top_row_miniboards, middle_row_miniboards, bottom_row_miniboards],
      turnX: self.x_turn,
      activeRow:self.active_row,
      activeCol: self.active_col
    }
  end

  def top_row
    miniboards.where(row: 0)
  end

  def middle_row
    miniboards.where(row: 1)
  end

  def bottom_row
    miniboards.where(row: 2)
  end
end
