def staggered_case(string)
  new_string = ""
  string.chars.each_with_index do |char, index|
    if index % 2 == 0
      new_string << char.upcase
    else
      new_string << char.downcase
    end
  end
  new_string
end

puts staggered_case('I Love Launch School!') == 'I LoVe lAuNcH ScHoOl!'
puts staggered_case('ALL_CAPS') == 'AlL_CaPs'
puts staggered_case('ignore 77 the 444 numbers') == 'IgNoRe 77 ThE 444 NuMbErS'
