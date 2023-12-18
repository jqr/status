# frozen_string_literal: true

$LOAD_PATH << File.expand_path(File.join(__dir__, "..", "lib"))

require "status"

require "minitest/autorun"
require "minitest/spec"
require "minitest/reporters"
require "minitest/focus"

Minitest::Reporters.use!(
  Minitest::Reporters::ProgressReporter.new(color: true),
  ENV,
  Minitest.backtrace_filter,
)

# class Minitest::Spec
#   before :each do
#   end

#   after :each do
#   end
# end
