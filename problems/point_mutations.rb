class DNA
  def initialize(strand)
    @strand = strand
  end

  def smallest
    @strand.size < @other_strand.size ? @strand : @other_strand
  end

  def hamming_distance(other_strand)
    @other_strand = other_strand
    count = 0
    max_length = smallest.size
    0.upto(max_length-1) do |iter|
      count += 1 if @strand[iter] != @other_strand[iter]
    end
    count
  end
end
