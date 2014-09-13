#This is a calculator.
require 'pry'
puts "Hey, I'm a calculator. Give me a number."
number1 = gets.chomp

puts "Give me a second number."
number2 = gets.chomp


puts "What do you want me to do with them? Enter a letter.\nA) +\nB) -\nC) *\nD) /\n"
operator = gets.chomp
result = 0

def operation(number1,number2, operator)
	o = operator.upcase
	n1 = number1.to_f
	n2 = number2.to_f
	if o == 'A'
		result = n1 + n2
	elsif o == 'B'
		result = n1 - n2
	elsif o == 'C'
		result = n1 * n2
	else o == 'D'
		result = n1 / n2
	end
	puts "The result is #{result}."
end

operation(number1, number2, operator)

