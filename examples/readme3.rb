$LOAD_PATH << File.expand_path(File.join(__dir__, "..", "lib"))
require "status"

total = 10_000
downloaded = 0
status = Status.new("Downloading", Status.rate { downloaded }, Status.progress(total) { downloaded })
Thread.new { loop { downloaded += rand(1_000); sleep 0.1 } }
status.print_while { downloaded < total}
