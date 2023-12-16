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
100.times do
  counter += 1
  sleep 0.1
  print status
end
print status.clear
puts "Done!"
```
![asciicast of code](examples/readme2.gif)

```ruby
counter = 0
status = Status.new("Downloading", Status.rate { counter })
100.times do
  counter += rand * 100
  sleep 0.1
  print status
end
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
