class Map
    FLASH_THRESHOLD=10

    attr_reader :map, :flash_count, :highlighted, :step_description

    def initialize(input, print_callback=nil, pause_callback=nil)
        @map = []
        @flash_count = 0
        @highlighted = nil
        @step_description = nil
        @ignore_pause = false

        @print = print_callback || -> { }
        @pause = pause_callback || -> { }

        input.each { |line| @map << line.chars.map(&:to_i) }

        @max_x = @map.length - 1
        @max_y = @map.first.length - 1
    end

    def flashes
        f = []
        each do |x, y, value|
            f << [x, y] if value == FLASH_THRESHOLD
        end
        f
    end

    def at(x, y)
        @map[x][y] if @map[x]
    end

    def set(value, x, y)
        @map[x][y] = value
    end

    def increment(x, y)
        value = nil
        highlight(x, y) do
            value = at(x, y)
            value += 1
            set(value, x, y)
            do_pause
        end
        
        # if we specifically crossed into FLASH_THRESHOLD, record it
        if value == FLASH_THRESHOLD
            @flash_count += 1
        end
    end

    def increment_all
        each do |x, y|
            increment(x, y)
        end
    end

    def reset_all_energy
        each do |x, y|
            value = at(x, y)
            set(0, x, y) if value >= FLASH_THRESHOLD
        end
    end

    def highlight(x, y)
        prev_highlight = @highlighted
        @highlighted = [x, y]
        yield
        @highlighted = prev_highlight
    end

    def try_flash(x, y)
        value = at(x, y)

        # ignore if we aren't flashing
        return if value != FLASH_THRESHOLD

        desc "evaluting adjacent cells to [#{x},#{y}]"

        highlight(x, y) do
            horiz = (x-1..x+1)
            vert = (y-1..y+1)

            do_pause

            # loop through all positions, ignore current
            horiz.each do |x1|
                vert.each do |y1|
                    # ignore if this is the current position
                    next if x1 == x && y1 == y
                    # ignore if this is off the map's edge
                    next if x1 < 0 || y1 < 0 || x1 > @max_x || y1 > @max_y

                    increment(x1, y1)
                    try_flash(x1, y1)
                    do_pause
                end
            end
        end

        desc "done evaluting adjacent cells to [#{x},#{y}]"
    end

    def handle_flashes
        # evaluating the entire map, which will dynamically change during evaluation,
        # means we need to first capture the locations of flashes at this point in time.
        # We want to use the current state of flashed octopii as an initiator,
        # as it triggers recursive behavior

        list = flashes
        desc "initializing with #{list.length} flashes"
        do_pause
        list.each do |flash|
            x,y = flash
            try_flash x, y
            do_pause
        end
        desc "finished evaluating flashes"
    end

    def step
        # Ignore the pausing during the boring parts
        @ignore_pause = true
        desc "incrementing all"
        increment_all

        @ignore_pause = false
        desc "evaluting flashes"
        handle_flashes

        @ignore_pause = true
        desc "resetting all energies"
        reset_all_energy

        @ignore_pause = false
    end

    def each
        (0...@map.length).each do |x|
            (0...@map[x].length).each do |y|
                yield(x, y, @map[x][y])
            end
        end
    end

    private

    def desc(msg=nil)
        @step_description = msg
    end

    def do_pause
        return if @ignore_pause
        @pause.call
    end
end