#!/usr/bin/env ruby
require_relative "../lib/status"

counter = 0
status = Status.new("Pollers", Poller.new(0.5, Spinner.new), Poller.new(1) { counter.round(2) })
100.times do
  counter += rand * 100
  sleep 0.1
  print status
end
