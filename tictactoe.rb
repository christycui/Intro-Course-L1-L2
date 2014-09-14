require 'pry'
# This is a Tic Tac Toe game.

# print a board and insert the pieces
# loop until there is a winner or all squares are taken
#   user plays
#   check for winner
#   computer plays
#   check for winner

# if there is a winner
#   show winning message
# else
#   "it's a tie"

#print a chessboard and initialize the positions

def initialize_board
  h = {}
  (1..9).each {|p| h[p] = ' '}
  h
end
def draw_board(board)
puts "       |       |       \n\
   #{board[1]}   |   #{board[2]}   |   #{board[3]}   \n\
       |       |       \n\
-------+-------+-------\n\
       |       |       \n\
   #{board[4]}   |   #{board[5]}   |   #{board[6]}   \n\
       |       |       \n\
-------+-------+-------\n\
       |       |       \n\
   #{board[7]}   |   #{board[8]}   |   #{board[9]}   \n\
       |       |       "
end

#game begins

def user_pick(board)
  puts "Choose a position (1 to 9) to place a piece: "
  user = gets.chomp
  while not (1..9).include?(user.to_i)
  if board.select {|key,value| value == 'X' || value == 'O'}.has_key?(user.to_i)
    puts "It's already picked. Please pick another piece: "
    user = gets.chomp
  else
    puts "That's not a valid position. Choose again: "
    user = gets.chomp
  end
  end
  user
end

def computer_pick(board)
  user = user.to_i
  left = board.select {|key, value| value == ' '}
  left.keys.sample
end
def end_game?(board)
  if WIN.select {|p| board[p[0]] ==  "X" and board[p[1]] == "X" and board[p[2]] == "X"} != []
    return "You won!"
  elsif WIN.select {|p| board[p[0]] ==  "O" and board[p[1]] == "O" and board[p[2]] == "O"} != []
    return "The computer won!"
  elsif board.values.select {|value| value == ' '} == []
    return "It's a tie"
  else
    return nil
  end
end
WIN = [[1, 2, 3], [1, 4, 7], [7, 8, 9], [3, 6, 9], [1, 5, 9], [3, 5, 7]]
ans = ''
begin
  board = initialize_board
  draw_board(board)
  begin
    user = user_pick(board)
    board[user.to_i] = 'X'
    mac = computer_pick(board)
    board[mac] = 'O'
    draw_board(board)
    status = end_game?(board)
  end until status
  puts status
  puts "Would you like to play again? Y/N"
  ans = gets.chomp
  while not ["Y", "N"].include?(ans.upcase)
    puts "Not a valid answer. Please enter again: Y/N"
    ans = gets.chomp
  end
end until ans.upcase == 'N'
