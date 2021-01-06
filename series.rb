class Series
  attr_reader :digits
  
  def initialize(series)
    @digits = series.chars.map(&:to_i)
  end

  def slices(n)
    raise ArgumentError if n > @digits.size
    array = []
    digits.each_with_index do |digit, index|
      array << digits.slice(index, n)
      break if index == digits.size - n
    end
    array
  end
end
