system('cls') || system('clear')

items = []
item_price = nil
item_quantity = nil
index = 1

puts "Simply hit 'enter' when you have no more items to add."

loop do
  loop do
    print "Enter the price of item #{index}: "
    item_price = gets.chomp
    break if item_price.to_i.to_s == item_price || item_price.to_f.to_s == item_price || item_price.to_f == 0.0
    puts "Please enter a valid input."
  end
  break if item_price.to_f == 0.0
  loop do
    print "Enter the quantity of item #{index}: "
    item_quantity = gets.chomp
    break if item_quantity.to_i.to_s == item_quantity || item_quantity.to_f.to_s == item_quantity
    puts "Please enter a valid input."
  end
  item_price = item_price.to_f
  item_quantity = item_quantity.to_i
  items << [item_price, item_quantity]
  index += 1
end

subtotal = 0
items.each do |item|
  subtotal += item[0] * item[1]
end

tax_amount = subtotal * 0.055
puts "------------------"
puts "Subtotal: $#{format('%.2f', subtotal)}"
puts "Tax: $#{format('%.2f', tax_amount)}"
puts "------------------"
puts "Total: $#{format('%.2f', (subtotal+tax_amount))}"
puts "------------------"
