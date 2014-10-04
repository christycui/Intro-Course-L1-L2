# OOP-style Tic Tac Toe

class Board
  attr_accessor :position

  def initialize
    @position= {}
    (1..9).each {|n| position[n] = ' '}
  end

  def draw_board
    system "clear"
    puts "     |     |    
  #{position[1]}  |  #{position[2]}  |  #{position[3]}  
     |     |     
-----+-----+-----
     |     |     
  #{position[4]}  |  #{position[5]}  |  #{position[6]}  
     |     |     
-----+-----+-----
     |     |     
  #{position[7]}  |  #{position[8]}  |  #{position[9]}  
     |     |     "
  end

  def position_in_row_with_two_X
    row = Game::WIN.select {|row| position.values_at(*row).count('X') == 2 and position.values_at(*row).count(' ') == 1}.flatten
    row.select {|n| position[n] == ' '}[0]
  end

  def position_in_row_with_two_O
    row = Game::WIN.select {|row| position.values_at(*row).count('O') == 2 and position.values_at(*row).count(' ') == 1}.flatten
    row.select {|n| position[n] == ' '}[0]
  end
end

class Player
end

class User < Player

  def initialize
  end

  def pick(board)
    begin
      puts "Choose a position to place the piece: 1 to 9"
      user_choice = gets.chomp
    end until board.position[user_choice.to_i] == ' '

    board.position[user_choice.to_i] = 'X'
  end

end

class Computer < Player

  def initialize
  end

  def pick(board)
    if board.position_in_row_with_two_X
      choice = board.position_in_row_with_two_X
    elsif board.position_in_row_with_two_O
      choice = board.position_in_row_with_two_O
    else
      choice = board.position.select {|k, v| v == ' '}.keys.sample
    end

    board.position[choice] = 'O'
  end

end

# game engine
class Game

  WIN = [[1,2,3],[3,6,9],[1,4,7],[7,8,9],[2,5,8],[4,5,6],[1,5,9],[3,5,7]]

  def initialize
  end

  def display_welcome_message(name)
    puts "Enter your name to start your Tic Tac Toe game: "
    name = gets.chomp
    puts "Welcome, #{name}!"
  end

  def check_winner(board)
    if WIN.select {|row| board.position.values_at(*row).count('X') == 3} != []
      "You won!!"
    elsif WIN.select {|row| board.position.values_at(*row).count('O') == 3} != []
      "You lost."
    elsif not board.position.has_value?(' ')
      "It's a tie."
    else
      nil
    end
  end

  def play

    begin
    # set up board and players
    board = Board.new
    board.draw_board
    user = User.new
    computer = Computer.new

    # game begins
      begin
        user.pick(board)
        computer.pick(board)
        board.draw_board
        status = check_winner(board)
      end until status
      puts status

      # ask user whether to play again
      ans = play_again?
    end while ans == 'Y'
  end

  def play_again?
    begin
      puts 'Would you like to play again? Y/N'
      ans = gets.chomp
    end until ['Y','N'].include?(ans.upcase)
    ans.upcase
  end
end

new_game = Game.new
new_game.play

