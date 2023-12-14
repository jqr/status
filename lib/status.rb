# frozen_string_literal: true

class Status
  CLEAR_TO_END = "\033[K"
  CLEAR_LINE = "\r" + CLEAR_TO_END
  attr_accessor :parts, :join

  def initialize(*parts, join: " ")
    @parts = parts
    @join = join
  end

  def <<(part)
    @parts << part
  end

  def add(part = nil, poll: false, &part_block)
    part = part || part_block
    part = Poller.new(poll, part, &part_block) if poll
    @parts << part
  end

  def to_s(clear: true, join: @join)
    rendered_parts = @parts.map do |part|
      if part.respond_to?(:call)
        part.call
      else
        part
      end
    end

    (clear ? CLEAR_LINE : "") + rendered_parts.compact.join(@join)
  end

  def clear
    CLEAR_LINE
  end

  def print_clear
    print clear
  end
end

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

class Progress
  attr_accessor :total, :size

  def initialize(total = 1, counter = nil, size: 10, &counter_block)
    @total = total
    @size = size
    @counter = counter || counter_block

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
    complete = count >= total

    fillable = size - @left.size - @right.size

    filled = count.to_f / total * fillable
    filled = 0 if filled < 0
    filled = fillable if filled > fillable
    unfilled = fillable - filled.floor - 1
    unfilled = 0 if unfilled < 0

    partial = filled % 1
    partial_filler = complete ? "" : @filler[partial * @filler.size.floor]

    @left + (@filler.last * filled.floor) + partial_filler + (@filler.first * unfilled) + @right
  end
end
