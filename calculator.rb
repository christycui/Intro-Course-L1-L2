#This is a calculator.

def operation(number1,number2, operator)
  o = operator.upcase
  n1 = number1.to_f
  n2 = number2.to_f
  result = case o
    when 'A' then n1 + n2
    when 'B' then n1 - n2
    when 'C' then n1 * n2
    when 'D' then n1 / n2
    when 'E' then n1 * n1
    when 'F' then 1 / n1
    when 'G' then "#{n1*100}%"
  end
  puts "The result is #{result}."
end

begin 
  puts "Hey, I'm a calculator. Give me a number."
  number1 = gets.chomp

  puts "What do you want me to do with it? Enter a letter.\
       \nA) +\nB) -\nC) *\nD) /\nE) x^2\nF) 1/x\nG) %"
  operator = gets.chomp

  if ['A', 'B', 'C', 'D'].include?(operator.upcase)
    puts "Give me a second number."
    number2 = gets.chomp
    operation(number1, number2, operator)
  else
    operation(number1,number2 = 0,operator)
  end

  puts "Wanna try again? Y / N"
  ans = gets.chomp
end while ans.upcase == 'Y'






