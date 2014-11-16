class AddOpenPickToBoards < ActiveRecord::Migration
  def change
    add_column :boards, :open_pick, :boolean, default: false
  end
end
