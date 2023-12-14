#!/usr/bin/env ruby
require_relative "../lib/status"

status = Status.new("Reticulating Splines", Spinner.new)
20.times do
  sleep 0.1
  print status
end
