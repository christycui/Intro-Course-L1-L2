# blackjack game

# Notes / Changes after watching the solution videos:
# 1. move method of calculating card value out of Card class, since the value is not solely dependent on the card itself (e.g. Ace)
# 2. initialize deck by making new instance objects of Card
# 3. shuffle the deck in initialize method rather than shuffle it in blackjack.play
# 4. create instance variables in initilize methods to extract states instead of creating many placeholders like player_total
# 5. initialize deck, player, dealer in initialize method of Blackjack
# 6. needed more layers of abstraction because I was passing around too many variables
# 7. while !player.is_busted? => while not player.is_busted?
# 8. set up constants for 17, 21 to extract them so that if you want to change them later they're easier to find

class Participant
  attr_accessor :name, :cards

  def initialize
    @name = 'Participant'
    @cards = []
  end

  def choose
  end

  def hit(deck, participant)
    puts "Dealing a new card for #{participant.name}..."
    new_card = get_card(deck, 1)
    cards.flatten!
    puts "#{participant.name}'s new card is #{new_card.join}. #{participant.name}'s total is #{total}."
  end

  def total
    # calculate total
    total = 0
    cards.each do |card| 
      if card.face_value[0] == 'A'
        total += 11
      elsif card.face_value.is_a? String
        total += 10 
      else
        total += card.face_value
      end
    end
    # correct for Aces
    count = cards.select {|card| card.face_value[0] == 'A'}.count
    while count > 0 and total > Blackjack::BLACKJACK
      total -= 10
      count -= 1
    end
    # returns total
    total
  end

  # n specifies the number of cards to deal
  def get_card(deck, n)
    new_card = deck.cards.pop(n)
    cards << new_card
    cards.flatten!
    new_card
  end
end


class Player < Participant

  def initialize(name)
    @name = name
    @cards = []
  end

  def choose(blackjack, deck, player, dealer)
    begin
      # ask player to hit or stay
      begin
        puts "Hit or stay? H/S"
        choice = gets.chomp
      end until ['H', 'S'].include?(choice.upcase)

      # if player chooses to hit
      hit(deck, player) if choice.upcase == 'H' 

      # check winner
      break if not blackjack.bust_or_win?(player, dealer)
    end until choice.upcase == 'S'
  end

end


class Dealer < Participant

  def initialize
    @name = 'Dealer'
    @cards = []
  end

  def choose(deck)
    while total < Blackjack::DEALER_HIT_MIN
      hit(deck, self)
    end
  end

end


class Deck
  attr_accessor :cards, :num_of_decks

  def initialize(n)
    @num_of_decks = n
    @cards = []
    ['Ace', 2, 3, 4, 5, 6, 7, 8, 9, 10, 'J', 'Q', 'K'].each do |face_value| 
      ['Hearts', 'Spades', 'Diamonds', 'Clubs'].each do |suit|
        @cards << Card.new(suit, face_value)
      end
    end

    @cards *= num_of_decks
    shuffle
  end

  def shuffle
    cards.shuffle!
  end
end


class Card
  attr_reader :suit, :face_value

  def initialize(suit, face_value)
    @suit = suit
    @face_value = face_value
  end

  def to_s
    "#{face_value} of #{suit}"
  end
end


class Blackjack

  BLACKJACK = 21
  DEALER_HIT_MIN = 17
  attr_accessor :deck, :dealer, :player

  def initialize
    # six decks are used to prevent card-counting players
    @deck = Deck.new(6)
    @dealer = Dealer.new
    @player = Player.new('Player1')
  end

  # return player's name
  def welcome_and_set_player_name
    puts "Welcome to Blackjack! Enter your name to start:"
    player.name = gets.chomp
  end

  def display_card
    puts "#{player.name}, the dealer's upcard is #{dealer.cards[0]}. Your cards are #{player.cards.join(' and ')}. Your total is #{player.total}. "
  end

  def display_final_results
    puts "Dealer's cards were #{dealer.cards.join(' and ')}. Dealer's total was #{dealer.total} and yours was #{player.total}."
  end

  def play
    system 'clear'
    # set up the game
    welcome_and_set_player_name
    player.get_card(deck, 2)
    dealer.get_card(deck, 2)
    display_card

    # check if player hit blackjack
    bust_or_win?(player, dealer)
    # player's turn
    player_turn  
    # dealer's turn if there isn't a winner
    dealer_turn

    play_again?
  end

  def player_turn
      choice = player.choose(self, deck, player, dealer)
      display_card if choice == 'H' 
  end

  def dealer_turn
      dealer.choose(deck)
      compare_hands if bust_or_win?(dealer, player)
      display_final_results(dealer, player)
  end

  # returns nil if card total >= 21 else returns a string
  def bust_or_win?(participant1, participant2)
    if participant1.total == BLACKJACK
      puts "#{participant1.name} hit blackjack!! #{participant2.name} lost." 
      play_again?
    elsif participant1.total > BLACKJACK
      puts "#{participant1.name} busted! #{participant2.name} won."
      play_again?
    else
      "continue"
    end
  end

  # compare total
  def compare_hands
    if player.total < dealer.total
      puts "You lost."
    elsif player.total > dealer.total
      puts "You won!!"
    else 
      puts "It's a tie."
    end
    play_again?
  end

  def play_again?
    begin
      puts "#{player.name}, would you like to play again?"
      ans = gets.chomp
    end until ['Y', 'N'].include?(ans.upcase)

    if ans.upcase == 'Y'
      deck = Deck.new(6)
      player.cards = []
      dealer.cards = []
      play
    else
      puts "Thanks for playing. Goodbye!"
      exit
    end
  end

end


game = Blackjack.new
game.play
