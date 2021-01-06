def calculate_simple_interest(rate, principal, years)
  format('%.2f', (principal + (principal * (rate/100) * years)))
end

principal = nil
rate = nil
years = nil

loop do
  print "Enter the principal: "
  principal = gets.chomp
  break if principal.to_f.to_s == principal || principal.to_i.to_s == principal
  puts "Please enter a valid input."
end

loop do
  print "Enter the rate of interest (% input): "
  rate = gets.chomp
  break if rate.to_f.to_s == rate || rate.to_i.to_s == rate
  puts "Please enter a valid input."
end

loop do
  print "Enter the number of years: "
  years = gets.chomp
  break if years.to_i.to_s == years
  puts "Please enter a valid input."
end

principal = principal.to_f
rate = rate.to_f
years = years.to_i

total = calculate_simple_interest(rate, principal, years)
puts "After #{years} years at #{rate}%, the investment will be worth $#{total}."
