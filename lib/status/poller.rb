# frozen_string_literal: true

module Status
  class Poller
    attr_reader :period, :inner, :inner_block

    def initialize(period, inner = nil, &inner_block)
      @period = period
      @inner = inner
      @inner_block = inner_block
    end

    def to_s
      now = Time.now.to_f
      if !@cached || @render_at <= now
        @render_at = now + period
        @cached = if @inner_block
          @inner_block.call.to_s
        else
          @inner.to_s
        end
      else
        @cached
      end
    end
  end
end
