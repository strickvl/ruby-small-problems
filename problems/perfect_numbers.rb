class PerfectNumber
  def self.classify(val)
    raise if val <= 0
    factors = (1..val-1).to_a.select do |n|
      val % n == 0
    end
    if factors.sum == val
      return "perfect"
    elsif factors.sum > val
      return "abundant"
    else
      return "deficient"
    end
  end
end
