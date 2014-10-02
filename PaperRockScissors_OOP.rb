# OOP style PRS

class Object
  attr_reader :hand
  def initialize(choice)
    @hand = choice
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

class Players
  def initialize
  end

  def user_pick
    begin
    puts "You pick first: P/R/S"
    user_choice = gets.chomp
    end until Game::CHOICES.keys.include?(user_choice.upcase)
    user_choice.upcase
  end

  def computer_pick
    Game::CHOICES.keys.sample
  end
end

class Game
  system("Clear")
  def initialize
    puts "Let's play Paper Rock Scissors!"
  end

  CHOICES = {'P'=>'paper', 'R'=>'rock','S'=>'scissors'}

  def play
    player = Players.new
    player_choice = Object.new(player.user_pick)
    computer_choice = Object.new(player.computer_pick)
    player_choice.compare(computer_choice.hand)
  end

  def play_again?
    begin 
      puts "Would you like to play again?"
      ans = gets.chomp
    end until ['Y','N'].include?(ans.upcase)
    ans.upcase
  end
  
end

begin
  game = Game.new
  game.play
  ans = game.play_again?
end while ans.upcase == 'Y'