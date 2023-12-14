# frozen_string_literal: true
require "test_helper"

describe Status do
  it "should have a smoke test" do
    s = Status.new("Hello", -> { 123 })
    s.add("456")
    _(s.to_s).must_equal "\r\e[KHello 123 456"
  end
end
