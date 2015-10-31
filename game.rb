require_relative 'board.rb'
# require_relative 'tile.rb'

MAX_STACK_SIZE = 200
tracer = proc do |event|
  if event == 'call' && caller_locations.length > MAX_STACK_SIZE
    fail "Probable Stack Overflow"
  end
end
set_trace_func(tracer)

class Game
  attr_accessor :board, :flag_count, :game_over
  attr_reader :name

  def initialize(player = "", board = Board.new)
    @player = player
    @board = board
    @flag_count = 10
    @loss = false
    @board.populate
  end

  def play
    until game_over?
      @board.cheating
      @board.display

      puts "Flag count: #{@flag_count}"
      prompt
      type = move_type(gets.chomp)
      prompt2
      position = get_pos(gets.chomp)
      take_turn(type, position)
    end
    @board.display
    @loss ? (puts "You lost!") : (puts "You win!")

  end

  def move_type(input)
    input = input.downcase
    if input == "f"
      move_type = "flag"
    elsif input == "r"
      move_type = "reveal"
    else
      raise "Not a valid move"
    end

    move_type
  end

  def get_pos(input)
    input = input.split(',').map(&:to_i)
    input
  end

  def take_turn(type, pos)
    if type == "flag"
      @board[pos].to_flag unless @flag_count == 0
      @flag_count -= 1
    else
      @board[pos].reveal
      @loss = true if @board[pos].bombed
    end

  end

  def game_over?
    return true if @loss || @board.all_visited?
    return false
  end

  # def flagged
  #
  # end
  #
  # def reveal
  #
  # end

  def prompt
    puts "(F)lag or (R)eveal?"
  end

  def prompt2
    puts "Choose a coordinate"
  end

end

game = Game.new("Player")
game.play
