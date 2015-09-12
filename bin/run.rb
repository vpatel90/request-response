require_relative '../db/setup'
require_relative '../lib/all'

me = Person.new(name: 'justin')
me.save

puts me.inspect
puts me.persisted?
puts Person.first.inspect
