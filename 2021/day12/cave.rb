class Cave
    CAVE_TYPE_START=0
    CAVE_TYPE_SMALL=1
    CAVE_TYPE_BIG=2
    CAVE_TYPE_END=3

    attr_reader :name, :cave_type, :connections

    def initialize(name)
        @name = name
        if @name == "start"
            @cave_type = CAVE_TYPE_START
        elsif @name == "end"
            @cave_type = CAVE_TYPE_END
        elsif @name.downcase == @name
            @cave_type = CAVE_TYPE_SMALL
        elsif @name.upcase == @name
            @cave_type = CAVE_TYPE_BIG
        else
            # UH OH.
        end

        @connections = []
    end

    def connect(cave)
        @connections << cave unless @connections.include? cave
    end

    def start?
        @cave_type == CAVE_TYPE_START
    end

    def small?
        @cave_type == CAVE_TYPE_SMALL || start? || end?
    end

    def big?
        @cave_type == CAVE_TYPE_BIG
    end

    def end?
        @cave_type == CAVE_TYPE_END
    end

    def ==(other)
        @name == other.name
    end

    def to_s
        @name
    end

    # def to_s_all
    #     conn = @connections.join(', ')
    #     "#{@name} [#{conn}]"
    # end
end