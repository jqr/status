# Status

**WARNING: Unpublished gem and likely to change a lot.**

A library for showing status messages during long running processes. Supports spinners, progress bars, rates, static and dynamic text.

```ruby
status = Status.new("Reticulating Splines", Status.spinner)
20.times do
  sleep 0.1
  print status
end
```
![asciicast of code](examples/readme1.gif)

```ruby
counter = 0
status = Status.new("Saving users", Status.progress(100) { counter })
50.times do
  counter += 1
  sleep 0.1
  print status
end
print status.clear
puts "Done!"
```
![asciicast of code](examples/readme2.gif)

```ruby 1x33
total = 10_000
downloaded = 0
status = Status.new("Downloading", Status.rate { downloaded }, Status.progress(total) { downloaded })
Thread.new { loop { downloaded += rand(1_000); sleep 0.1 } }
status.print_while { downloaded < total}
```
![asciicast of code](examples/readme3.gif)

Costly computation, or data too volatile? Pollers let you only render them every N seconds.

```ruby
counter = 0
status = Status.new("Pollers", Status.poller(0.5, Status.spinner), Status.poller(1) { counter.round(2) })
100.times do
  counter += rand * 100
  sleep 0.1
  print status
end
```
![asciicast of code](examples/readme4.gif)

Mixing output:

```ruby 6x19
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
```
![asciicast of code](examples/readme5.gif)
