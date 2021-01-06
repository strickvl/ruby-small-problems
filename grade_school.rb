class School
  def initialize
    @school = {}
  end

  def to_h
    @school.keys.sort.each_with_object({}) do |grade, hash|
      hash[grade] = @school[grade].sort
    end
  end

  def add(name, grade)
    if @school.keys.include?(grade)
      @school[grade] << name
    else
      @school[grade] = [name]
    end
  end

  def grade(number)
    return [] if !@school.keys.include?(number)
    @school[number]
  end
end
