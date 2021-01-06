def format_number(input)
  format('%.2f', input)
end

print "How many euros are you exchanging? "
original = gets.chomp.to_f
print "What is the exchange rate? "
exchange_rate = gets.chomp.to_f

puts "$#{format_number(original)} euros at an exchange rate of #{format_number(exchange_rate)} is #{format_number(original * (exchange_rate/10))} U.S. dollars"
