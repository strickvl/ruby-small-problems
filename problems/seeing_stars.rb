def star(int)
  return if int < 7 || int.even?
  final = []
  ((int/2)-1).downto(0) do |val|
    final << "*#{" " * val}*#{" " * val}*".center(int)
  end
  final << "*" * int
  0.upto((int/2)-1) do |val|
    final << "*#{" " * val}*#{" " * val}*".center(int)
  end
  puts final
end

star(6)
puts star(10)
puts star(7)
puts star(9)

=begin
input int
output a star but printed line by line

RULES:
int corresponds to the number of lines the star is (as well as its spread horizontally)
integer must be an odd number
integer must be >= 7
middle line is always just a row of stars n long



=end
