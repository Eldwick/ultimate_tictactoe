class Tile < ActiveRecord::Base
  belongs_to :miniboard

  def self.initialize_array
    tiles_array = []
    (0..2).each do |row_index|
      (0..2).each do |col_index|
        tile = Tile.create(row: row_index, column: col_index)
        tiles_array << tile
      end
    end
    tiles_array
  end
end
