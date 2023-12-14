# frozen_string_literal: true

guard(:minitest, all_on_start: false, all_env: { "COVERAGE" => true }) do

  ignore(%r{^\..*})
  ignore(%r{^coverage})

  # Test config
  watch(%r{^test/test_.*\.rb$}) { "test" }
  watch(%r{^Guardfile$}) { "test" }

  # Tests
  watch(%r{^test/.*_test\.rb$})

  # Core lib/* => test/*
  watch(%r{^lib/(.*/)?([^/]+)\.rb$}) do |m|
    "test/#{m[1]}#{m[2]}_test.rb"
  end
end
