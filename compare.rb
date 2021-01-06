def compare(str)
  after = yield(str)
  puts "Before: #{str}"
  puts "After: #{after}"
end

compare('hi') { |word| word.upcase }

# Output:
# Before: hi
# After: HI
