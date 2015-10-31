require_relative 'tile.rb'
require 'byebug'
class Board
  attr_reader :grid

  def initialize
    @grid = Array.new(9) {Array.new(9)}
    # populatere
  end

  def [](pos)
    x, y = pos[0],pos[1]
    @grid[x][y]
  end

  def []=(pos, val)
    x,y = pos[0],pos[1]
    @grid[x][y] = val
  end

  def populate
    add_bombs
    @grid.each_with_index do |row, i|
      row.each_index do |j|
          unless self[[i, j]]
            self[[i, j]] =  Tile.new([i, j], self)
            # self[[i, j]].count = self[[i, j]].neighbor_bomb_count
          end
      end
    end
  end

  def add_bombs
    count = 0
    until count == 10
      x = rand(9)
      y = rand(9)
      unless self[[x, y]]
        self[[x,y]] = Tile.new([x, y], self, true)
        count += 1
      end
    end
  end

  def display
    puts  "  | 0 || 1 || 2 || 3 || 4 || 5 || 6 || 7 || 8 |"
    puts ""
    @grid.each_with_index do |row, i|
      display = "#{i} "
      row.each do |tile|

        if tile.flagged == true
          display << "| F |"
        elsif tile.bombed == true && tile.revealed == true
          display << "| X |"
        elsif tile.count > 0 && tile.revealed == true
          display << "| " + tile.count.to_s + " |"
        elsif tile.revealed == true
          display << "| _ |"
        else
          display << "| * |"
        end

        # if tile.bombed == true
        #   display << "| X |"
        # elsif tile.count > 0
        #   display << "| " + tile.count.to_s + " |"
        # elsif tile.flagged == true
        #   display << "| F |"
        # else
        #   display << "| * |"
        # end
      end
      puts display
      puts "  ---------------------------------------------"
    end
  end
  def cheating
    puts "solution"
    @grid.each_with_index do |row, i|
      display = ""
      row.each do |tile|

        if tile.flagged == true
          display << "| F |"
        elsif tile.bombed == true
          display << "| X |"
        elsif tile.count > 0
          display << "| " + tile.count.to_s + " |"
        else
          display << "| * |"
        end

        # if tile.bombed == true
        #   display << "| X |"
        # elsif tile.count > 0
        #   display << "| " + tile.count.to_s + " |"
        # elsif tile.flagged == true
        #   display << "| F |"
        # else
        #   display << "| * |"
        # end
      end
      puts display
      puts "---------------------------------------------"
    end
  end

  def all_visited?
    # p @grid.flatten
    @grid.flatten.each do |tile|
       return false if tile.revealed == false && tile.flagged == false
     end
     return true
  end

end
#
# a = Board.new
# a.populate
# a.display
