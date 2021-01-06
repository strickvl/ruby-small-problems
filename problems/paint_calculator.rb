SQ_FT_PER_GALLON = 350

length = nil
width = nil
type = nil

loop do
  print "What type of a room are you painting? Square or circle? "
  type = gets.chomp.downcase
  break if ["square", "circle"].include?(type)
  puts "Please choose between a square or a circle."
end

loop do
  print "What is the length of the room you'd like to paint? "
  length = gets.chomp
  break if length.to_i.to_s == length
  puts "Please enter a valid input."
end

loop do
  print "What is the width of the room you'd like to paint? "
  width = gets.chomp
  break if width.to_i.to_s == width
  puts "Please enter a valid input."
end

length = length.to_i
width = width.to_i

case type
when "square"
  area = length * width
when "circle"
  area = Math::PI * ((length/2)**2)
end

gallons, remainder = area.divmod(SQ_FT_PER_GALLON)

gallons_unit = nil
gallons += 1 if remainder != 0
gallons > 1 ? gallons_unit = "gallons" : gallons_unit = "gallon"

puts "You will need to purchase #{gallons} #{gallons_unit} of paint to cover #{area.round(2)} square feet."
