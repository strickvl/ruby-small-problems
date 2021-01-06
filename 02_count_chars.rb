string = nil

loop do
  print "What is the input string? "
  string = gets.chomp
  break if string.size > 0
  puts "Please enter a valid string."
end

if string.size == 1
  puts "#{string} has #{string.size} character."
else
  puts "#{string} has #{string.size} characters."
end
