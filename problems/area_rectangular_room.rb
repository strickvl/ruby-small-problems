CONVERSION_FACTOR = 0.09290304

length = nil
width = nil
unit = nil

loop do
  print "Are you inputting values in metres or feet? "
  unit = gets.chomp
  break if ["metres", "feet"].include?(unit.downcase)
  puts "Please choose either metres or feet."
end

loop do
  print "What is the length of the room in #{unit}? "
  length = gets.chomp
  break if length.to_i.to_s == length
  puts "Please enter valid input (an integer)."
end

loop do
  print "What is the width of the room in #{unit}? "
  width = gets.chomp
  break if width.to_i.to_s == width
  puts "Please enter valid input (an integer)."
end

length = length.to_i
width = width.to_i

puts "You entered dimensions of #{length} #{unit} by #{width} #{unit}."

case unit
when "feet"
  area_feet = length * width
  area_metres = area_feet * CONVERSION_FACTOR
when "metres"
  area_metres = length * width
  area_feet = area_metres / CONVERSION_FACTOR
end

puts <<-MSG
The area is:
#{area_feet.round(3)} square feet
#{area_metres.round(3)} square metres
MSG
