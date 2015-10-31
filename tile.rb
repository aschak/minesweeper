class Tile
  attr_reader :bombed, :pos
  attr_accessor :count, :revealed, :flagged

  def initialize(pos, board, bombed=false, flagged = false, revealed = false)
    @bombed = bombed
    @flagged = flagged
    @revealed = revealed
    @pos = pos
    @board = board
    @count = neighbor_bomb_count #unless @bombed
  end


  def reveal
    @revealed = true
    reveal_neighbors unless @bombed
    # reveal_neighbors
  end

  def reveal_neighbors
    # if @count == 0
    #   neighbors.each do |tile|
    #     unless tile.revealed
    #       tile.reveal_neighbors
    #       tile.revealed = true
    #     end
    #   end
    # end
    visited_tile = [self]
    queue = [self]
    while queue.any?
      # debugger
      current = queue.shift
      current.neighbors.each do |tile|
        next if visited_tile.include?(tile)
        tile.revealed = true unless tile.bombed
        visited_tile << tile
        queue << tile if tile.count == 0
      end
    end


  end

  def to_flag
    @flagged = true
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
    neigh.each do |tile|
       next if tile.nil?
       count += 1 if tile.bombed
    end
    return count
  end

end
