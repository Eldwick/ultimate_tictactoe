class CreateBoards < ActiveRecord::Migration
  def change
    create_table :boards do |t|
      t.boolean :x_turn, default: true

      t.timestamps
    end
  end
end
