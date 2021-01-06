class Prime
  def self.nth(number)
    raise ArgumentError if number < 1
    primes = []
    current = 2
    until primes.size == number
      primes << current if Prime.new.prime?(current)
      current += 1
    end
    primes.last
  end

  def prime?(val)
    return false if (2..val - 1).any? { |int| val % int == 0 }
    true
  end
end
