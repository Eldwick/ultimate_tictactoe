class CreateMiniboards < ActiveRecord::Migration
  def change
    create_table :miniboards do |t|
      t.integer :row
      t.integer :column
      t.string :mark
      t.integer :board_id

      t.timestamps
    end
  end
end
