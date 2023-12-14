#!/usr/bin/env ruby
require_relative "../lib/status"

counter = 0
status = Status.new("Downloading", Rate.new { counter })
100.times do
  counter += rand * 100
  sleep 0.1
  print status
end
