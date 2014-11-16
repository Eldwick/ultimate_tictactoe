class AddRowAndColumnToBoards < ActiveRecord::Migration
  def change
    add_column :boards, :active_row, :integer
    add_column :boards, :active_col, :integer
  end
end
