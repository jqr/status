$LOAD_PATH << File.expand_path(File.join(__dir__, "..", "lib"))
require "status"

counter = 0
status = Status.new("Downloading", Status.rate { counter })
100.times do
  counter += rand * 100
  sleep 0.1
  print status
end
