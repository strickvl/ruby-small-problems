# FIRST TRY USING ALIAS
# def add_hello(text)
#   text + " hello"
# end
#
# alias :hello_greeting :add_hello
#
# puts hello_greeting("margot")

# SECOND TRY using alias_method
# class TestClass
#   def add_hello(text)
#     "hello " + text
#   end
#
#   alias_method :helper_method, :add_hello
# end
#
# puts TestClass.new.add_hello("margot")
# puts TestClass.new.helper_method("margot")

# THIRD TRY in main space

def add_hello(text)
  "hello " + text
end

alias_method :helper_method, :add_hello

puts add_hello("margot")
puts helper_method("margot")
