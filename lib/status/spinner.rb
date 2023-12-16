# frozen_string_literal: true

module Status
  class Spinner
    # DEFAULT = %w(- \\ | /)
    # DEFAULT = %w(. o O)
    DEFAULT = %w(... ..o .oO oOo Oo. o.. ...)
    # DEFAULT = %w(... .o. oOo OOO)
    # DEFAULT = %w(▁ ▂ ▃ ▄ ▅ ▆ ▇ █)
    # DEFAULT = %w(▖ ▘ ▝ ▗)
    # DEFAULT = %w(▉ ▊ ▋ ▌ ▍ ▎ ▏)
    # DEFAULT = %w(. o O @ *)
    # DEFAULT = %w(...o ..o. .o.. o...)
    # DEFAULT = %w(....o ...o. ..o.. .o... o....)
    # DEFAULT = %w(x +)

    attr_accessor :frames, :index, :bounce

    def initialize(frames = DEFAULT, bounce: false)
      @frames = frames
      @index = 0
      @bounce = bounce
    end

    def to_s
      if @bounce
        @index = (@index + 1) % (@frames.size * 2 - 2)
        if @index >= @frames.size
          @frames[@frames.size - 2 - @index]
        else
          @frames[@index]
        end
      else
        @index = (@index + 1) % @frames.size
        @frames[@index]
      end
    end
  end
end
