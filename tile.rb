class Tile
  attr_reader :bombed, :flagged, :revealed, :pos

  def initialize(bombed=false, flagged = false, revealed = false, pos)
    @bombed = bombed
    @flagged = flagged
    @revealed = revealed
    @pos = pos
  end


  def reveal
    @revealed = true
  end

  def neighbors

  end

  def neighbor_bomb_count

  end


end
