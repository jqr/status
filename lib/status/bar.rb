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

      (clear ? CLEAR_LINE : "") + rendered_parts.compact.join(join)
    end

    def clear
      CLEAR_LINE
    end

    def print_clear
      print clear
    end
  end
end
