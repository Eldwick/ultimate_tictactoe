class Miniboard < ActiveRecord::Base
  belongs_to :board
  has_many :tiles

  def self.initialize_array
    miniboards_array = []
    (0..2).each do |row_index|
      (0..2).each do |col_index|
        miniboard = Miniboard.create(row: row_index, column: col_index)
        tiles = Tile.initialize_array
        miniboard.tiles << tiles
        miniboards_array << miniboard
      end
    end
    miniboards_array
  end

  def checkComplete 
    top_left,top_center,top_right = self.top_row
    middle_left,middle_center,middle_right = self.middle_row
    bottom_left,bottom_center,bottom_right = self.bottom_row

    ##Check horizonal row complete
    if ((top_left.mark == top_center.mark) && (top_center.mark == top_right.mark) && top_left.mark)
      self.update(mark: top_left.mark)
      return top_left.mark
    elsif ((middle_left.mark == middle_center.mark) && (middle_center.mark == middle_right.mark) && middle_left.mark)
      self.update(mark: middle_left.mark)
      return middle_left.mark
    elsif ((bottom_left.mark == bottom_center.mark) && (bottom_center.mark == bottom_right.mark) && bottom_left.mark)
      self.update(mark: bottom_left.mark)
      return bottom_left.mark
    end

    ##Check vertical row complete
    if ((top_left.mark == middle_left.mark) && (middle_left.mark == bottom_left.mark) && top_left.mark)
      self.update(mark: top_left.mark)
      return top_left.mark
    elsif ((top_center.mark == middle_center.mark) && (middle_center.mark == bottom_center.mark) && top_center.mark)
      self.update(mark: top_center.mark)
      return top_center.mark
    elsif ((top_right.mark == middle_right.mark) && (middle_right.mark == bottom_right.mark) && top_right.mark)
      self.update(mark: top_right.mark)
      return top_right.mark
    end

    ##Check horizonal complete
    if ((top_left.mark == middle_center.mark) && (middle_center.mark == bottom_right.mark) && top_left.mark)
      self.update(mark: top_left.mark)
      return top_left.mark
    elsif ((top_right.mark == middle_center.mark) && (middle_center.mark == bottom_left.mark) && top_right.mark)
      self.update(mark: top_right.mark)
      return top_right.mark
    end

    return false
  end

  def tree
    top_row_tiles = []
    middle_row_tiles = []
    bottom_row_tiles = []
    top_row.each do |tile|
      top_row_tiles << tile.mark
    end
    middle_row.each do |tile|
      middle_row_tiles << tile.mark
    end
    bottom_row.each do |tile|
      bottom_row_tiles << tile.mark
    end
    return [top_row_tiles, middle_row_tiles, bottom_row_tiles]
  end

  def top_row
    tiles.where(row: 0)
  end

   def middle_row
    tiles.where(row: 1)
  end

   def bottom_row
    tiles.where(row: 2)
  end
end
