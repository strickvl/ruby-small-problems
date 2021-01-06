# print "What is your name? "
# name = gets.chomp
# puts "Hello #{name}, nice to meet you!"

people = {
  "Alex" => "we meet again, friend!",
  "Saba" => "nicey you're the best!"
}

puts "What is your name?"
name = gets.chomp
greeting = nil
if people.keys.include?(name)
  greeting = people[name]
else
  greeting = "nice to meet you!"
end

puts "Hello #{name}, #{greeting}"
