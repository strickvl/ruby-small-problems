class Clock
  def initialize(hour, minute)
    @hour = hour
    @minute = minute
  end

  def self.at(hour, minute=0)
    clock = Clock.new(hour, minute)
    clock
  end

  def to_s
    "#{format('%02d', @hour)}:#{format('%02d', @minute)}"
  end

  def +(minute)
    if @minute + minute < 60
      @minute += minute
    elsif @minute + minute >= 60
      hour_increment = minute/60
      minute_increment = minute - (hour_increment * 60)
      @minute += minute_increment
      @hour += hour_increment
    end
    self
  end

  def -(minute)
    if @minute - minute > 0
      @minute -= minute
    elsif @minute - minute < 0
      hour_increment = minute/60
      minute_increment = minute - (hour_increment * 60)
      @minute -= minute_increment
      @hour -= hour_increment
    end
    self
  end

  def ===(other_clock)

  end
end

clock = Clock.at(10) + 3
p clock.to_s
