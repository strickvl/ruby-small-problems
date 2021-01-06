def prompt(string)
  puts "=> #{string}"
end

def integer?(input)
  input.to_i.to_s == input
end

def float?(input)
  input.to_f.to_s == input
end

bill_amount = 0
tip_rate = 0

loop do
  prompt "What is the bill amount?"
  bill_amount = gets.chomp
  break if (integer?(bill_amount) || float?(bill_amount)) && bill_amount.to_f > 0
  prompt "Please enter a valid bill amount."
end

loop do
  prompt "What is the tip rate? (%)"
  tip_rate = gets.chomp
  break if (integer?(tip_rate) || float?(tip_rate)) && tip_rate.to_f > 0
  prompt "Please enter a valid tip rate."
end

bill_amount = bill_amount.to_f
tip_rate = tip_rate.to_f

tip = (bill_amount * (tip_rate / 100)).round(2)
total = (bill_amount + tip).round(2)

puts "Tip: $#{tip}"
puts "Total: $#{total}"
