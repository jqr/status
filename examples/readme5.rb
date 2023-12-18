$LOAD_PATH << File.expand_path(File.join(__dir__, "..", "lib"))
require "status"

status = Status.new("Waiting")
threads = 4.times.map do |index|
  Thread.new do
    sleep index + 1
    # Safely puts without interfering with the status bar
    status.puts "hello from thread #{index}"
  end
end
status.add(Status.progress(threads.size) { threads.reject(&:alive?).size })
status.print_until_complete(clear: false)
puts "All finished!"
