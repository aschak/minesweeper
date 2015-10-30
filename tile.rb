class Tile
  attr_reader :bombed, :flagged, :revealed, :pos

  def initialize(pos, board, bombed=false, flagged = false, revealed = false)
    @bombed = bombed
    @flagged = flagged
    @revealed = revealed
    @pos = pos
    @board = board
    @count = neighbor_bomb_count
  end


  def reveal
    @revealed = true
  end

  NEIGH_DIFF = [
    [1, 0],
    [1, 1],
    [1, -1],
    [0, 1],
    [0, -1],
    [-1, 1],
    [-1, -1],
    [-1, 0]
  ]

  def neighbors
    neighbors_pos = []
    NEIGH_DIFF.each do |diff|
      x = self.pos[0] + diff[0]
      y = self.pos[1] + diff[1]
      neighbors_pos << [x, y] if x.between?(0,8) && y.between?(0,8)
    end
    neighbors_pos.map {|pos| @board[pos]}
  end

  def neighbor_bomb_count
    neigh = neighbors
    count = 0
    neigh.each { |tile| count += 1 if tile.bombed }
    return count
  end


end
