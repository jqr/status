# frozen_string_literal: true

require "status/bar"
require "status/poller"
require "status/progress"
require "status/rate"
require "status/ratio"
require "status/spinner"
require "status/version"

module Status
  def self.new(...)
    Bar.new(...)
  end

  def self.poller(...)
    Poller.new(...)
  end

  def self.progress(...)
    Progress.new(...)
  end

  def self.ratio(...)
    Ratio.new(...)
  end

  def self.rate(...)
    Rate.new(...)
  end

  def self.spinner(...)
    Spinner.new(...)
  end
end
