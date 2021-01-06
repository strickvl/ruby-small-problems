def each(arr)
  counter = 0
  while counter < arr.size
    yield(arr[counter])
    counter += 1
  end
  arr
end

puts each([1, 2, 3, 4, 5]) {|num| "do nothing"}.select{ |num| num.odd? } == [1, 3, 5]
