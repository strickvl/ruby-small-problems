class Machine
  def start
    flip_switch(:on)
  end

  def stop
    flip_switch(:off)
  end

  def state
    switch
  end

  private
  
  def flip_switch(desired_state)
    self.switch = desired_state
  end

  attr_writer :switch
  attr_reader :switch
end

machine = Machine.new
machine.start
puts machine.state
machine.stop
puts machine.state
