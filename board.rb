class Board
  attr_reader :grid

  def initialize
    @grid = Array.new(9) {Array.new(9)}
  end

  def [](pos)
    x, y = pos
    @grid[x][y]
  end
  




end
