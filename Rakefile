require "bundler/setup"
require "bundler/gem_tasks"
require "rake/testtask"

Rake::TestTask.new(:test) do |t|
  t.libs << "test"
  t.libs << "lib"
  t.test_files = FileList["test/**/*_test.rb"]
end

task default: :test

desc "Render README examples into gifs"
task :render do
  Dir.chdir(File.join(__dir__)) do
    counter = 0
    r = File.read("README.md").gsub(/```ruby\n.+?\n```\n(!\[.*?\]\(.*?\)\n)?/m) do |m|
      counter += 1
      ruby = m.lines[1..]
      ruby.pop if ruby.pop != "```"
      ruby_filename = "examples/readme#{counter}.rb"
      File.open(ruby_filename, "w") do |file|
        file.write("#!/usr/bin/env ruby\n")
        file.write(%Q[require_relative \"../lib/status\"\n\n])
        file.write(ruby.join(""))
        File.chmod(0644)
      end
      FileUtils.chmod "u+x", ruby_filename

      image_filename = "examples/readme#{counter}.gif"

      cmd = "asciinema rec - --command #{ruby_filename} --rows 1 --cols 30 --overwrite --quiet | agg - #{image_filename} --theme github-light"
      abort("failed: #{cmd}") unless system(cmd)

      "```ruby\n#{ruby.join}```\n![asciicast of code](#{image_filename})\n"
    end

    File.open("README.md", "w") { _1.write(r) }
  end
end
