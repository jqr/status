# frozen_string_literal: true

module Status
  class Ratio
    attr_accessor :total, :size

    def initialize(total = 1, counter = nil, &counter_block)
      @total = total
      @size = size
      @counter = counter || counter_block
      @complete = false

      raise ArgumentError, "counter or counter_block required" unless @counter
    end

    def to_s
      count = @counter.call
      @complete = count >= @total
      "#{count}/#{@total}"
    end

    def complete?
      @complete
    end
  end
end
