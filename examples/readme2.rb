$LOAD_PATH << File.expand_path(File.join(__dir__, "..", "lib"))
require "status"

counter = 0
status = Status.new("Saving users", Status.progress(100) { counter })
50.times do
  counter += 1
  sleep 0.1
  print status
end
print status.clear
puts "Done!"
