class CircularQueue
  def initialize(size)
    @buffer = Array.new(size)
  end

  def enqueue(item)
    # if any items == nil, then use the empty_space_selector to choose position + place
    if @buffer.any? {|item| item.nil?}
      place(item, empty_space_selector)

    # else, find most recent item, replace item to the right of it
    else
      latest = newest
      if latest[1] < @buffer.size-1
        place(item, latest[1]+1)
      else
        place(item, 0)
      end
    end
  end

  def dequeue
    return nil if empty?
    # find the oldest item in the queue
    item_for_removal = oldest
    #remove the oldest item
    @buffer[oldest[1]] = nil
    # return the element I removed
    item_for_removal[0]
  end
  
  def items
    @buffer
  end
  
  private

  def oldest
    return nil if empty?
    items = @buffer.select { |item| item != nil }
    oldest = items[0]
    items.each do |item|
      oldest = item if item[1] < oldest[1]
    end
    [oldest[0], oldest[2]]
  end

  def newest
    return nil if empty?
    items = @buffer.select { |item| item != nil }
    newest = items[0]
    items.each do |item|
      newest = item if item[1] > newest[1]
    end
    [newest[0], newest[2]]
  end

  def empty?
    @buffer.all? { |item| item.nil? }
  end

  def empty_space_selector
    # if 3 spaces nil, then place in the first position
    # if there's a single space, if so place there
    # if two spaces, find most recent item and place to right of that
    #   (place in P1 if most recent is P3)
    return 0 if empty?
    return single_space if single_space != nil
    last_item = newest
    if last_item[1] < @buffer.size-1
      return last_item[1]+1
    else
      return 0
    end
  end

  def single_space
    return @buffer.index(nil) if @buffer.count(nil) == 1
    nil
  end

  def place(item, location)
    time = Time.new
    @buffer[location] = [item, time, location]
  end
end

queue = CircularQueue.new(3)
puts queue.dequeue == nil

queue.enqueue(1)
queue.enqueue(2)
puts queue.dequeue == 1

queue.enqueue(3)
queue.enqueue(4)
puts queue.dequeue == 2

queue.enqueue(5)
queue.enqueue(6)
queue.enqueue(7)
puts queue.dequeue == 5
puts queue.dequeue == 6
puts queue.dequeue == 7
puts queue.dequeue == nil

queue = CircularQueue.new(4)
puts queue.dequeue == nil

queue.enqueue(1)
queue.enqueue(2)
puts queue.dequeue == 1

queue.enqueue(3)
queue.enqueue(4)
puts queue.dequeue == 2

queue.enqueue(5)
queue.enqueue(6)
queue.enqueue(7)
puts queue.dequeue == 4
puts queue.dequeue == 5
puts queue.dequeue == 6
puts queue.dequeue == 7
puts queue.dequeue == nil
