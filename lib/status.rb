# frozen_string_literal: true

require "status/bar"
require "status/poller"
require "status/progress"
require "status/rate"
require "status/ratio"
require "status/spinner"
require "status/version"

module Status
  def self.new(*args, **options, &block)
    Bar.new(*args, **options, &block)
  end

  def self.poller(*args, **options, &block)
    Poller.new(*args, **options, &block)
  end

  def self.progress(*args, **options, &block)
    Progress.new(*args, **options, &block)
  end

  def self.ratio(*args, **options, &block)
    Ratio.new(*args, **options, &block)
  end

  def self.rate(*args, **options, &block)
    Rate.new(*args, **options, &block)
  end

  def self.spinner(*args, **options, &block)
    Spinner.new(*args, **options, &block)
  end
end
