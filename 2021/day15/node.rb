class Node
    attr_accessor :neighbors
    attr_reader :x, :y, :value

    def initialize(y, x, value)
        @y, @x, @value = y, x, value
        @neighbors = []
    end

    def ==(other)
        other.x == @x && other.y == @y && other.value == @value
    end

    def to_s
        "[#{@y},#{@x}] (val: #{@value}) (num neighbors: #{@neighbors.length})"
    end
end