class SumOfMultiples
  def initialize(*factors)
    @factors = factors
  end

  def self.to(max)
    set = SumOfMultiples.new(3, 5)
    set.to(max)
  end

  def to(max)
    return 0 if max == 1
    multiples = []
    1.upto(max-1) do |val|
      multiples << val if @factors.any? {|factor| val % factor == 0}
    end
    multiples.sum
  end
end
