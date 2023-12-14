require_relative "lib/status/version"

Gem::Specification.new do |s|
  s.name        = "status"
  s.version     = Status::VERSION
  s.summary     = "Dynamic status messages"
  s.description = "Easily print dynamic status messages in your terminal"
  s.authors     = ["Elijah Miller"]
  s.email       = "elijah.miller@gmail.com"
  s.files       = `git ls-files README.md *.gemspec lib`.split("\n")
  s.homepage    = "https://github.com/jqr/status"
  s.license     = "MIT"

  s.add_development_dependency("rake")
  s.add_development_dependency "pry"
  s.add_development_dependency("minitest-spec")
  s.add_development_dependency("minitest-reporters")
  s.add_development_dependency("minitest-focus")
  s.add_development_dependency("guard")
  s.add_development_dependency("guard-minitest")
end
