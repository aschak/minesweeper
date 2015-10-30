require_relative 'tile.rb'

class Board
  attr_reader :grid

  def initialize
    @grid = Array.new(9) {Array.new(9)}
  end

  def [](*pos)
    x, y = pos
    @grid[x][y]
  end

  def populate
    add_bombs
    @grid.each do |row|
      row.each do |col|
        @grid[row][col] ||= Tile.new([row, col], self)
      end
    end
  end

  def add_bombs
    count = 0
    until count == 10
      x = rand(9)
      y = rand(9)
      unless @grid[x][y]
        @grid[x][y] = Tile.new([x, y], self, true)
        count += 1
      end
    end
  end


  

end

a = Board.new
a.populate

p a.grid
