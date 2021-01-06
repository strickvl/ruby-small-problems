def select(arr)
  counter = 0
  selected = []
  while counter < arr.size
    selected << arr[counter] if yield(arr[counter])
    counter += 1
  end
  selected
end

array = [1, 2, 3, 4, 5]

puts select(array) { |num| num.odd? } == [1, 3, 5]
puts select(array) { |num| puts num } == []
puts select(array) { |num| num + 1 } == [1, 2, 3, 4, 5]
