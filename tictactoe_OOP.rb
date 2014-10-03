# OOP-style Tic Tac Toe

class Board
  attr_accessor :a

  def initialize
    @a= {}
    (1..9).each {|p| a[p] = ' '}
  end

  def draw_board
    system "clear"
    puts "     |     |    
  #{a[1]}  |  #{a[2]}  |  #{a[3]}  
     |     |     
-----+-----+-----
     |     |     
  #{a[4]}  |  #{a[5]}  |  #{a[6]}  
     |     |     
-----+-----+-----
     |     |     
  #{a[7]}  |  #{a[8]}  |  #{a[9]}  
     |     |     "
  end

end

class Player

  def initialize(name)
    puts "Welcome, #{name}!"
  end 

  def user_pick(board)
    begin
      puts "Choose a position to place the piece: 1 to 9"
      user_pick = gets.chomp
    end until board.a[user_pick.to_i] == ' '
    board.a[user_pick.to_i] = 'X'
  end

  def computer_pick(board)
    computer_pick = board.a.select {|k, v| v == ' '}.keys.sample
    board.a[computer_pick] = 'O'
  end

  def check_winner(board)
    if Game::WIN.select {|set| board.a.values_at(*set).count('X') == 3} != []
      "You won!!"
    elsif Game::WIN.select {|set| board.a.values_at(*set).count('O') == 3} != []
      "You lost."
    elsif not board.a.has_value?(' ')
      "It's a tie."
    else
      nil
    end
  end

end

class Game

  WIN = [[1,2,3],[3,6,9],[1,4,7],[7,8,9],[2,5,8],[4,5,6],[1,5,9],[3,5,7]]

  def initialize
    puts "Enter your name to start: "
    @name = gets.chomp
  end

  def play
    board = Board.new
    board.draw_board
    user = Player.new(@name)
    begin
      user.user_pick(board)
      board.draw_board
      status = user.check_winner(board)
      user.computer_pick(board)
      board.draw_board
      status = user.check_winner(board)
    end until status
    puts status
  end

  def play_again?
    begin
      puts 'Would you like to play again?'
      ans = gets.chomp
    end until ['Y','N'].include?(ans.upcase)
    ans
  end
end

game = Game.new

begin
  game.play
  ans = game.play_again?
end until ans.upcase == 'N'