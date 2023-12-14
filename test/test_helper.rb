# frozen_string_literal: true

GEM_ROOT = File.join(File.dirname(__FILE__), "..")
$: << GEM_ROOT + "/lib"
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

class Minitest::Spec
  before :each do
  end

  after :each do
  end
end
