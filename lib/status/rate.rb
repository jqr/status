# frozen_string_literal: true

module Status
  class Rate
    attr_accessor :counter

    def initialize(round: 2, &counter)
      @round = round
      @counter = counter
    end

    def to_s
      now = Time.now
      count = @counter.call
      @last_count ||= count
      @last_count_at ||= now
      rate = (count - @last_count) / (now - @last_count_at)
      if rate.nan?
        "?/s"
      else
        "%.#{@round}f/s" % rate.round(@round)
      end
    end
  end
end
