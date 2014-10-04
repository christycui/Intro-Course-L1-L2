# OOP style PRS

class Hand

  attr_reader :hand

  def initialize(hand)
    @hand = hand
  end

  def compare(another_hand)

    puts "You chose #{Game::CHOICES[hand]} and computer picked #{Game::CHOICES[another_hand]}."

    if hand == another_hand
      puts "It's a tie."
    elsif (hand == 'P' and another_hand == 'R') || (hand == 'R' and another_hand == 'S') || (hand == 'S' and another_hand == 'P')
      puts "You won!!"
    else
      puts "You lost."
    end
  end

end

class Player

end

# User inherits from Player class
class User < Player

  def initialize
  end

  def pick

    begin
    puts "You pick first: P/R/S"
    user_choice = gets.chomp
    end until Game::CHOICES.keys.include?(user_choice.upcase)

    user_choice.upcase

  end

end

# Computer also inherits from Player class
class Computer < Player

  def initialize
  end

  def pick
    Game::CHOICES.keys.sample
  end

end

# game engine
class Game

  system("Clear")

  def initialize
  end

  def display_welcome_message
    puts "Let's play Paper Rock Scissors!"
  end

  CHOICES = {'P'=>'paper', 'R'=>'rock','S'=>'scissors'}

  def play

    display_welcome_message

    begin
      # play game
      player_choice = Hand.new(User.new.pick)
      computer_choice = Hand.new(Computer.new.pick)
      player_choice.compare(computer_choice.hand)

      # ask user whether to play again
      ans = play_again?
    end while ans == 'Y'

  end

  def play_again?

    begin 
      puts "Would you like to play again?"
      ans = gets.chomp
    end until ['Y','N'].include?(ans.upcase)

    ans.upcase

  end
  
end

new_game = Game.new
new_game.play
