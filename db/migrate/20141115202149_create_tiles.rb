class CreateTiles < ActiveRecord::Migration
  def change
    create_table :tiles do |t|
      t.integer :row
      t.integer :column
      t.string :mark
      t.integer :miniboard_id

      t.timestamps
    end
  end
end
