def foo
  "foo"
end

alias_method :baz, :foo

puts baz
puts foo
