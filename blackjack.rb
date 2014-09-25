# blackjack game
# six decks (an array) are used to prevent card counting players
# an array are passed around instead of a hash (since hash can't have duplicate pairs)

def new_deck
  suit = ['Hearts', 'Diamonds', 'Clubs', 'Spades']
  card = *(2..10)
  card.push('Ace', 'J', 'Q', 'K')
  deck = card.product(suit).map {|card| card.join(" of ")}
  deck
end

def card_value(card)
  if card[0..1] == '10'
    value = 10
  elsif card[0].to_i != 0
    value = card[0].to_i
  elsif card[0] == 'A'
    value = 11
  else
    value = 10
  end
  value
end

def calculate_total(array_of_cards, total=0)
  count_A = array_of_cards.select{|card| card[0] == 'A'}.count
  total = 0
  if count_A == 0
    array_of_cards.each {|card| total += card_value(card)}
  else
    while count_A != 0
      array_of_cards.each {|card| total += card_value(card)}
      if total > 21
        total = total - 10
      else
        break
      end
      count_A -= 1
    end 
  end
  total
end

def play_again?
  begin
    puts "Would you like to play again?"
    ans = gets.chomp
  end until ['Y','N'].include?(ans.upcase)
  ans.upcase
end


def hit_or_stay(name, player, dealer, player_total)
  begin
    puts "#{name}, your cards are: #{player.join(" and ")}.\n" +
          "One of dealer's cards is #{dealer[0]}.\nYour total is #{player_total}. Hit or stay? H/S"
    choice = gets.chomp
  end until ['H', 'S'].include?(choice.upcase) 
  choice.upcase
end

# game starts
ans = ''
puts "Let's play some Blackjack! Enter your name to start: "
name = gets.chomp
begin
  #use six decks to prevent player counting
  deck = new_deck*6
  #player deals two cards
  player = deck.sample(2)
  player_total = calculate_total(player)
  deck.delete_if {|card| player.include?(card)}
  # dealer deals two cards
  dealer = deck.sample(2)
  dealer_total = calculate_total(dealer)
  deck.delete_if {|card| dealer.include?(card)}


  # no winner yet
  while player_total < 21
    choice = hit_or_stay(name, player, dealer, player_total)
    # player chooses to stay
    if choice == 'S'
      # condition when dealer has to hit
      while dealer_total <= 17
        # check for soft hand
        if dealer == 17 and dealer.select {|card| card[0] == 'A'} != []
          break
        else
          dealer << deck.sample
          dealer_total = calculate_total(dealer)
          deck.delete_if {|card| dealer.include?(card)}
        end
      end
      # check winner
      if dealer_total == 21
        puts "Dealer hit blackjack. You lost :'("
        break
      elsif dealer_total > 21
        puts "Dealer busted. You won!!"
        break
      else
        # check winner again by comparing
        if player_total > dealer_total
          puts "You won!!"
        elsif player_total < dealer_total
          puts "You lost :'("
        else
          puts "It's a tie. "
        end
        break 
      end
    else  # if player chooses to hit
      player << deck.sample
      player_total = calculate_total(player)
      deck.delete_if {|card| player.include?(card)}   
    end
      # check winner
    if player_total == 21
      puts "You hit blackjack!! \nYour cards were: #{player.join(" and ")}."
    elsif player_total > 21
      puts "You busted! \nYour cards were: #{player.join(" and ")}."
    end

  end 

  puts  "Your total was #{player_total} and dealer's total was #{dealer_total}." 
  ans = play_again? # ask if the player wants to play again

end until ans == 'N'

