#This is a calculator.

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
	elsif o == 'D'
		result = n1 / n2
	elsif o == 'E'
		result = n1 * n1
	elsif o == 'F'
		result = 1 / n1
	elsif o == 'G'
		result = "#{n1*100}%"
	end
	puts "The result is #{result}."
end

begin 
	puts "Hey, I'm a calculator. Give me a number."
	number1 = gets.chomp

	puts "What do you want me to do with it? Enter a letter.\
			 \nA) +\nB) -\nC) *\nD) /\nE) x^2\nF) 1/x\nG) %"
	operator = gets.chomp

	if ['A', 'B', 'C', 'D'].include?(operator)
		puts "Give me a second number."
		number2 = gets.chomp
		operation(number1, number2, operator)
	else
		operation(number1,number2 = 0,operator)
	end

	puts "Wanna try again? Y / N"
	ans = gets.chomp
end while ans == 'Y'






