

def new_deck
  suit = ['Hearts', 'Diamonds', 'Clubs', 'Spades']
  card = *(2..10)
  card.push('Ace', 'J', 'Q', 'K')
  card = card.product(suit).map {|card| card.join(" of ")}
  deck = {}
  card.each do |card| 
    if card[0..1] == '10'
      deck[card] = 10
    elsif card[0].to_i != 0
      deck[card] = card[0].to_i
    elsif card[0] == 'A'
      deck[card] = 11
    else
      deck[card] = 10
    end
  end
  deck
end

def calculate_total(array_of_cards, deck, total=0,deck0)
  count_A = array_of_cards.select{|card| card[0] == 'A'}.count
  if count_A == 0
    deck0.values_at(*array_of_cards).each {|value| total += value}
  else
    while count_A != 0
      deck0.values_at(*array_of_cards).select {|value| total += value}
      if total > 21
        total = total - 10
      else
        total
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


def get_choice(name,player,player_total)
  begin
    puts "#{name}, your cards are: #{player.join(" and ")}. " +
          "Your total is #{player_total}. \nHit or stay? H/S"
    choice = gets.chomp
  end until ['H', 'S'].include?(choice.upcase) 
  choice.upcase
end

# start playing
ans = ''
puts "Let's play some Blackjack! Enter your name to start: "
name = gets.chomp
begin
  deck0 = new_deck
  deck = new_deck
  player = deck.keys.sample(2)
  player_total = calculate_total(player, deck,deck0)
  deck.delete_if {|key,value| player.include?(key)}
  # dealer_dealt_cards
  dealer = deck.keys.sample(2)
  dealer_total = calculate_total(dealer, deck,deck0)
  deck.delete_if {|key,value| dealer.include?(key)}
  while player_total < 21
    choice = get_choice(name,player,player_total)
    if choice == 'S'
      while dealer_total < 17
        dealer << deck.keys.sample
        dealer_total = calculate_total(dealer, deck, deck0)
        deck.delete_if {|key,value| dealer.include?(key)}
      end
      if dealer_total == 21
        puts "Dealer hit blackjack. You lost :'("
        break
      elsif dealer_total < 21 and dealer_total >= 17
          if player_total > dealer_total
            puts "You won!!"
            break
          elsif player_total < dealer_total
            puts "You lost :'("
            break
          else
            puts "It's a tie. "
            break
          end
      else
        puts "Dealer busted. You won!!"
        break
      end
    else
        player << deck.keys.sample
        player_total = calculate_total(player, deck, deck0)
        deck.delete_if {|key,value| player.include?(key)}   
    end
  end
  if player_total == 21
    puts "You hit blackjack!!"
  end
  if player_total > 21
    puts "You busted!"
  end

  puts "Your total was #{player_total} and dealer's total was #{dealer_total}" 
  ans = play_again?
end until ans == 'N'

