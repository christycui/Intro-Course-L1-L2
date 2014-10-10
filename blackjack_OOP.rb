# blackjack game

class Participant
  def choose
  end

  # returns new card
  def hit(deck, array_of_cards)
    array_of_cards << get_card(deck, 1).join
  end

  def stay
  end

  # input must be an array
  def total(array_of_cards)
    total = 0
    array_of_cards.each {|card| total += Card.new(card).value}
    # count the number of Aces in the array
    count = array_of_cards.select {|card| card[0] == 'A'}.count
    # Ace will take on 1 if total > 21
    while count > 0 and total > 21
      total -= 10
      count -= 1
    end
    # returns total
    total
  end

  def get_card(deck, n)
    deck.pop(n)
  end

  # returns nil if card total >= 21 else returns a string
  def bust_or_win?(participant1, participant2, card_total)
    if card_total == 21
      puts "#{participant1} hit blackjack!! #{participant2} lost." 
    elsif card_total > 21
      puts "#{participant1} busted! #{participant2} won." 
    else
      "continue"
    end
  end
end


class Player < Participant
  def initialize
  end

  def to_s
    "You"
  end

  def choose(deck, player, dealer, player_card)
    # ask player to choose
    begin
      begin
        puts "Hit or stay? H/S"
        choice = gets.chomp
      end until ['H', 'S'].include?(choice.upcase)
      # if player chooses to hit
      hit(deck, player, player_card) if choice.upcase == 'H' 
      # check winner
      break if not bust_or_win?(player, dealer, player.total(player_card))
    end until choice.upcase == 'S'
  end

  def hit(deck, player, player_card)

      new_card = get_card(deck, 1).join
      player_card << new_card
      puts "Your new card is #{new_card}. Your new total is #{total(player_card)}."
  end
end


class Dealer < Participant
  def initialize
  end

  def to_s
    "Dealer"
  end

  def choose(deck, dealer, player, player_card, dealer_card)
    while dealer.total(dealer_card) < 17
      hit(deck, dealer_card)
    end
    stay(player, player_card, dealer, dealer_card) if bust_or_win?(dealer, player, dealer.total(dealer_card))  
  end

  def stay(player, player_card, dealer, dealer_card)
    if player.total(player_card) < dealer.total(dealer_card)
      puts "You lost."
    elsif player.total(player_card) > dealer.total(dealer_card)
      puts "You won!!"
    else 
      puts "It's a tie."
    end
  end
end


class Deck
  attr_accessor :deck

  def initialize(n)
    @deck = []
    ['Ace', 2, 3, 4, 5, 6, 7, 8, 9, 10, 'J', 'Q', 'K'].product(['Hearts', 'Spades', 'Diamonds', 'Clubs']).each {|combo| deck << combo.join(' of ')}
    @deck = deck*n
  end

  def to_s
    puts deck
  end

  def shuffle
    deck.shuffle!
  end
end


class Card
  attr_reader :face, :value

  def initialize(card)
    @face = card
    if face[0] == 'A'
      @value = 11
    elsif face[0].to_i == 0 or face[0] == '1'
      @value = 10
    else
      @value = face[0].to_i
    end  
  end
end


class Blackjack
  def initialize
  end

  # return player's name
  def display_welcome_message
    puts "Welcome to Blackjack! Enter your name to start:"
    gets.chomp
  end

  def display_card(name, player, player_card, dealer_card)
    puts "#{name}, the dealer's upcard is #{dealer_card[0]}. Your cards are #{player_card.join(' and ')}. Your total is #{player.total(player_card)}. "
  end

  def display_final_results(dealer, dealer_card, player, player_card)
    puts "Dealer's cards were #{dealer_card.join(' and ')}. Dealer's total was #{dealer.total(dealer_card)} and yours was #{player.total(player_card)}."
  end

  def play(name)
    system 'clear'
    # set up the game
    deck = Deck.new(3).shuffle
    player = Player.new
    dealer = Dealer.new
    player_card = player.get_card(deck, 2)
    dealer_card = dealer.get_card(deck, 2)
    display_card(name, player, player_card, dealer_card)

    # check winner
    player.bust_or_win?(player, dealer, player.total(player_card))
    dealer.bust_or_win?(dealer, player, dealer.total(dealer_card))
    # player's turn
    if player.total(player_card) < 21 and dealer.total(dealer_card) < 21
      choice = player.choose(deck, player, dealer, player_card)
      display_card(name, player, player_card, dealer_card) if choice == 'H'     
    end   
    # dealer's turn if there isn't a winner
    if player.total(player_card) < 21 and dealer.total(dealer_card) < 21
      dealer.choose(deck, dealer, player, player_card, dealer_card)
      display_final_results(dealer, dealer_card, player, player_card)
    end

    play_again?(name)
  end

  def play_again?(name)
    begin
      puts "#{name}, would you like to play again?"
      ans = gets.chomp
    end until ['Y', 'N'].include?(ans.upcase)

    if ans.upcase == 'Y'
      play(name)
    else
      puts "Thanks for playing. Goodbye!"
    end
  end
end


game = Blackjack.new
name = game.display_welcome_message
game.play(name)
