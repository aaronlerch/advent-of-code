require 'curses'

class DisplayHelper
    FLASHED=220
    GRAY_START=237
    HIGHLIGHT=200
    WHITE=255

    class << self
        def init
            Curses.noecho
            Curses.init_screen
            Curses.crmode
            Curses.start_color
        end

        def with_color(color)
            Curses.init_pair(color, color, 0)
            Curses.attrset(Curses.color_pair(color))

            yield

            Curses.init_pair(WHITE, WHITE, 0)
            Curses.attrset(Curses.color_pair(WHITE))
        end

        def color_for_value(value)
            return DisplayHelper::FLASHED if value == "*"
            return DisplayHelper::WHITE if value * 2 > 255
            
            DisplayHelper::GRAY_START + (value.to_i * 2)
        end

        def draw
            Curses.refresh
            yield
        end

        def close
            Curses.close_screen
        end
    end
end