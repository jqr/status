# frozen_string_literal: true

module Status
  class Progress
    attr_accessor :total, :size

    def initialize(total = 1, counter = nil, size: 10, &counter_block)
      @total = total
      @size = size
      @counter = counter || counter_block
      @complete = false

      raise ArgumentError, "counter or counter_block required" unless @counter

      # Theme
      @filler = [" "] + %w(▏ ▎ ▍ ▌ ▋ ▊ ▉ █)
      # @filler = [" "] + %w(▁ ▂ ▃ ▄ ▅ ▆ ▇ █)
      # @filler = [" "] + %w(. o O)
      # @filler = [" "] + %w(- o)
      # @filler = %w(_ - o O)
      @left = "["
      @right = "]"

      # Always get at least one for progress display
      @right = "" if size - @left.size - @right.size < 1
      @left = ""  if size - @left.size < 1
    end

    def to_s
      count = @counter.call
      @complete = count >= total

      fillable = size - @left.size - @right.size

      filled = count.to_f / total * fillable
      filled = 0 if filled < 0
      filled = fillable if filled > fillable
      unfilled = fillable - filled.floor - 1
      unfilled = 0 if unfilled < 0

      partial = filled % 1
      partial_filler = @complete ? "" : @filler[partial * @filler.size.floor]

      @left + (@filler.last * filled.floor) + partial_filler + (@filler.first * unfilled) + @right
    end

    def complete?
      @complete
    end
  end
end
