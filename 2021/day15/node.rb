class Node
    attr_reader :x, :y, :value, :children

    def initialize(y, x, value)
        @y, @x, @value = y, x, value
        @neighbors = []
    end

    def add_neighbor(node)
        @neighbors << node unless @neighbors.include? node
    end

    def ==(other)
        other.x == @x && other.y == @y && other.value == @value
    end

    def to_s
        "[#{@y},#{@x}] (val: #{@value}) (num neighbors: #{@neighbors.length})"
    end
end