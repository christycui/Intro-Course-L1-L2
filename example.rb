require 'pry'
def new_deck
  suit = ['Hearts', 'Diamonds', 'Clubs', 'Spades']
  card = *(2..10)
  card.push('A', 'J', 'Q', 'K')
  card = card.product(suit).map {|card| card.join(" of ")}
  deck = {}
  card.each do |card| 
    if card == 10
      deck[card] = 10
      binding.pry
    elsif card[0].to_i != 0
      deck[card] = card[0].to_i
    elsif card[0] == 'A'
      deck[card] = 0
    else
      deck[card] = 10
    end
  end
  deck
end

p new_deck