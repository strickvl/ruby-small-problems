string = nil

loop do
  puts "What is the input string?"
  string = gets.chomp
  break if string.size > 0
  puts "Please enter something as the input string."
end

puts "#{string} has #{string.size} characters."
