class Sieve
  def initialize(limit)
    @limit = limit
    @possibles = (2..limit).to_a.each_with_object({}) { |item, hash| hash[item] = "unknown" }
  end

  def primes
    loop do
      break if @possibles.values.all? { |n| n == "prime" }
      check_for_primes
    end
    @possibles.keys
  end

  def check_for_primes
    @possibles.select { |_, value| value == "unknown" }.each do |num, _|
      @possibles.delete_if { |i| i % num == 0 }
      @possibles[num] = "prime"
      break
    end
  end
end

# p Sieve.new(100000).primes
