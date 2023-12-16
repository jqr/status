$LOAD_PATH << File.expand_path(File.join(__dir__, "..", "lib"))
require "status"

counter = 0
status = Status.new("Pollers", Status.poller(0.5, Status.spinner), Status.poller(1) { counter.round(2) })
100.times do
  counter += rand * 100
  sleep 0.1
  print status
end
