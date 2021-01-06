def reduce(arr, default = arr.first)
  counter = 1
  accum = default
  while counter < arr.size
    accum = yield(accum, arr[counter])
    counter += 1
  end
  accum
end

array = [1, 2, 3, 4, 5]

puts reduce(array) { |acc, num| acc + num } == 15
#puts reduce(array, 10) { |acc, num| acc + num }# == 25

puts reduce(['a', 'b', 'c']) { |acc, value| acc += value } == 'abc'
p reduce([[1, 2], ['a', 'b']]) { |acc, value| acc + value } == [1, 2, 'a', 'b']
