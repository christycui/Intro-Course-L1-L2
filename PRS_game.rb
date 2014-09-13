# Paper Rock Scissors

def win(ans1,ans2)
  if ans1 == ans2
    puts "It's a tie."
  elsif (ans1 == 'paper' and ans2 == 'rock') || (ans1  == 'rock' and ans2 == 'scissor') || (ans1 == 'scissor' and ans2 == 'paper')
    puts "You won!"
  else 
    puts "The computer won!"
  end
end

ans = 'Y'

until ans.upcase == 'N'
  puts "Let's play Paper Rock Scissors!"
  begin
    puts "You pick first: P/R/S"
    ans1 = gets.chomp
  end until ['P','R','S'].include?(ans1.upcase)
  ans2 = rand(3)

ans2 = ['paper', 'rock', 'scissors'][ans2]

  if ans1.upcase == 'P'
    ans1 = "paper"
  elsif ans1.upcase == 'R'
    ans1 = "rock"
  elsif ans1.upcase == 'S'
    ans1 = "scissor"
  end

  puts "You picked #{ans1} and computer picked #{ans2}."
  win(ans1,ans2)
  puts "Try again? Y/N"
  ans = gets.chomp
end
