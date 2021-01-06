def find_suspect(numbers)
  array = numbers.sort.chunk_while {|a, b| a == b}.to_a
  array = array.sort_by {|subarr| subarr.size}
  return array[0][0] unless array[0].size == array[1].size
  nil
end

p find_suspect([1, 2, 3, 4, 2, 2, 1, 4, 4]) #== 3
p find_suspect([1, 1, 2, 2]) #== nil
p find_suspect([1, 1, 2, 2, 2]) #== 1
p find_suspect([1, 2, 3, 4, 4, 3]) #== nil
