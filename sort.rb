def swap_values!(arr, index1, index2)
  temp = arr[index1]
  arr[index1] = arr[index2]
  arr[index2] = temp
  true
end

def sort_method(arr)
  unchanged = 0

  until unchanged == arr.length - 1
    unchanged = 0
    counter = 0

    while counter <= (arr.length - 2)
      puts "arr is #{arr} and unchanged is #{unchanged}"
      val1 = arr[counter]
      val2 = arr[counter + 1]

      if val1 <= val2
        unchanged += 1
      elsif val1 > val2
        swap_values!(arr, counter, counter + 1)
      end
      counter += 1
    end

  end

  arr
end

p sort_method([7, 2, 8, 6, 2]) # returns [2, 2, 6, 7, 8]
puts sort_method([7, 2, 8, 6, 2]) == [2, 2, 6, 7, 8]

# p sort_method([7, 2, 3, 5, 9]) # returns [2, 3, 5, 7, 9]
# puts sort_method([7, 2, 3, 5, 9]) == [2, 3, 5, 7, 9]

# input is an array
# output is the same array object, but sorted
#
# need to iterate through an array enough times to sort it
# also need to do this sorting IN PLACE (i.e. on the object itself)
#
# no data structures needed (except a temporary variable to swap elements around)
#
# algorithm:
#
# - initialise a changed variable to 0
# - init an unchanged variable to 0
#
# LOOP 1: have a loop that runs UNTIL changed == 0 && unchanged == arr.length - 1
#   - initialise a changed variable to 0
#   - init an unchanged variable to 0
#
#   LOOP 2: iterate over all the consecutive pairs of elements once
#     compare two vals
#     if val1 is <= val2
#       unchanged += 1
#       next
#     if val1 is > val2
#       swap_values
#       changed += 1
#
#   END LOOP 1
#
# END LOOP 1
#
# return array
