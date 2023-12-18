# frozen_string_literal: true

module Status
  class Bar
    CLEAR_TO_END = "\e[K"
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

      @last_to_s = (clear ? CLEAR_LINE : "") + rendered_parts.compact.join(join)
    end

    def clear
      CLEAR_LINE
    end

    def print_clear
      print clear
    end

    def puts(...)
      print_clear
      super(...)
      print @last_to_s if @last_to_s
    end

    def print_until(wait: 0.05, clear: true)
      loop do
        print self
        break if yield
        sleep wait
      end
      clear ? print_clear : Kernel.puts
    end

    def implicit_completable
      @parts.detect { _1.is_a?(Progress) || _1.is_a?(Ratio) } || raise("No Progress/Rate part to check for completion")
    end

    def print_until_complete(**options)
      print_until(**options) do
        implicit_completable.complete?
      end
    end

    def print_while(**options)
      print_until(**options) do
        !yield
      end
    end
  end
end
