#!/usr/bin/env ruby
require_relative "../lib/status"

counter = 0
status = Status.new("Saving users", Progress.new(100) { counter })
100.times do
  counter += 1
  sleep 0.1
  print status
end
print status.clear
puts "Done!"
