$LOAD_PATH << File.expand_path(File.join(__dir__, "..", "lib"))
require "status"

status = Status.new("Reticulating Splines", Status.spinner)
20.times do
  sleep 0.1
  print status
end
