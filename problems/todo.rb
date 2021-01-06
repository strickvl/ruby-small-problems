# This class represents a todo item and its associated
# data: name and description. There's also a "done"
# flag to show whether this todo item is done.

class Todo
  DONE_MARKER = 'X'
  UNDONE_MARKER = ' '

  attr_accessor :title, :description, :done

  def initialize(title, description='')
    @title = title
    @description = description
    @done = false
  end

  def done!
    self.done = true
  end

  def done?
    done
  end

  def undone!
    self.done = false
  end

  def to_s
    "[#{done? ? DONE_MARKER : UNDONE_MARKER}] #{title}"
  end
end

# This class represents a collection of Todo objects.
# You can perform typical collection-oriented actions
# on a TodoList object, including iteration and selection.

class TodoList
  attr_accessor :title, :todos

  def initialize(title)
    @title = title
    @todos = []
  end

  def add(item)
    if item.class == Todo
      @todos << item
      display_list
    else
      raise TypeError.new("Can only add Todo objects")
    end
  end

  def display_list
    puts "TO DO LIST: #{@title}".center(30)
    puts "------------------------------"
    @todos.each do |item|
      puts item
    end
    puts "------------------------------"
  end

  def <<(item)
    add(item)
  end

  def size
    @todos.size
  end

  def first
    @todos.first
  end

  def last
    @todos.last
  end

  def to_a
    @todos.each_with_object([]) do |item, array|
      array << item.title
    end
  end

  def done?
    @todos.all? do |item|
      item.done?
    end
  end

  def item_at(index)
    if index < @todos.size
      return @todos[index]
    else
      raise IndexError
    end     
  end

  def mark_done_at(index)
    if index < @todos.size
      @todos[index].done!
      puts @todos[index]
    else
      raise IndexError
    end
  end

  def mark_undone_at(index)
    if index < @todos.size
      @todos[index].undone!
      puts @todos[index]
    else
      raise IndexError
    end
  end

  def done!
    @todos.each do |item|
      item.done!
    end
    puts "All items marked as done."
  end

  def shift
    @todos.shift
  end

  def pop
    @todos.pop
  end

  def remove_at(index)
    if index < @todos.size
      @todos.delete_at(index)
      puts "An item was deleted from index #{index}."
    else
      raise IndexError
    end
  end

  def to_s
    display_list
  end

  def each
    counter = 0
    self.todos.size.times do
      yield(self.todos[counter])
      counter += 1
    end
    self.todos
  end
end

todo1 = Todo.new("Buy milk")
todo2 = Todo.new("Clean room")
todo3 = Todo.new("Go to gym")

list = TodoList.new("Today's Todos")
list.add(todo1)
list.add(todo2)
list.add(todo3)

list.each do |todo|
  puts todo                   # calls Todo#to_s
end

