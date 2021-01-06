def valid_input?(input)
  (input.to_i.to_s == input) && input.to_i > 0
end

first = nil
second = nil

loop do
  print "What is the first number? "
  first = gets.chomp
  break if valid_input?(first)
  puts "Please enter a valid integer."
end

first = first.to_i

loop do
  print "What is the second number? "
  second = gets.chomp
  break if valid_input?(second)
  puts "Please enter a valid integer."
end

second = second.to_i

puts <<-MESSAGE
#{first} + #{second} = #{first + second}
#{first} - #{second} = #{first - second}
#{first} * #{second} = #{first * second}
#{first} / #{second} = #{first.to_f / second}
MESSAGE
