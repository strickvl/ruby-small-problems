print "What is your current age? "
age = gets.chomp.to_i
print "At what age would you like to retire? "
retirement_age = gets.chomp.to_i

delta = retirement_age - age
current_year = Time.now.year

case
when delta > 0
  puts "You have #{delta} years left until you can retire."
  puts "It's #{current_year}, so you can retire in #{current_year + delta}."
when delta <= 0
  puts "You can already retire!"
end
