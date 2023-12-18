# frozen_string_literal: true

require "status/bar"
require "status/poller"
require "status/progress"
require "status/rate"
require "status/ratio"
require "status/spinner"
require "status/version"

module Status
  def self.new(**options, &block)
    Bar.new(**options, &block)
  end

  def self.poller(**options, &block)
    Poller.new(**options, &block)
  end

  def self.progress(**options, &block)
    Progress.new(**options, &block)
  end

  def self.ratio(**options, &block)
    Ratio.new(**options, &block)
  end

  def self.rate(**options, &block)
    Rate.new(**options, &block)
  end

  def self.spinner(**options, &block)
    Spinner.new(**options, &block)
  end
end
