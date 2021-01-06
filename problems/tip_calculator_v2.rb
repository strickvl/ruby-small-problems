def integer?(input)
  input == input.to_i.to_s
end

def float?(input)
  input == input.to_f.to_s
end

def valid_input?(input)
  (integer?(input) || float?(input)) && input.to_f > 0
end

def round_and_present(input)
  format('%.2f', input.round(2))
end

bill = nil
tip_input = nil
tip_percentage = nil

loop do
  puts "What is the total bill?"
  bill = gets.chomp
  break if valid_input?(bill)
  puts "Please enter a valid number for the bill amount."
end

loop do
  puts "What is the tip percentage?"
  tip_input = gets.chomp
  tip_percentage = tip_input.to_f/100
  break if valid_input?(tip_input)
  puts "Please enter a valid number for the bill amount."
end

tip = bill.to_f * tip_percentage
total = bill.to_f + tip

puts "The tip is $#{round_and_present(tip)}."
puts "The total is $#{round_and_present(total)}."
