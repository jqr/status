# frozen_string_literal: true

require "test_helper"

describe Status do
  it "should have a smoke test" do
    s = Status.new("Hello", -> { 123 }, Status.spinner, Status.rate { 2 }, Status.progress(3) { 2 }, Status.ratio(3) { 2 })
    s.add("456")
    _(s.to_s).must_equal "\r\e[KHello 123 ..o ?/s [█████▎  ] 2/3 456"
    s.puts("abc")
  end
end
