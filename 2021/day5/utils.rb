class Segment
    attr_reader :x1, :y1, :x2, :y2

    def initialize(x1,y1,x2,y2)
        @x1, @y1, @x2, @y2 = x1, y1, x2, y2
    end

    def min_x
        [@x1,@x2].min
    end

    def max_x
        [@x1,@x2].max
    end

    def min_y
        [@y1,@y2].min
    end

    def max_y
        [@y1,@y2].max
    end

    def to_points
        points = []
        if x1 == x2 # horizontal
            (min_y..max_y).each do |y|
                points << [x1,y]
            end
        elsif y1 == y2 # vertical
            (min_x..max_x).each do |x|
                points << [x,y1]
            end
        else # diagonal
            # iterate across both x1 -> x2 and y1 -> y2 at the same time
            x = x1
            y = y1
            loop do
                points << [x,y]

                # if we've reached the end, stop! else increment
                break if x == x2 && y == y2

                if x1 < x2
                    x += 1
                else
                    x -= 1
                end

                if y1 < y2
                    y += 1
                else
                    y -= 1
                end
            end
        end

        points
    end

    def to_s
        "#{@x1},#{@y1} -> #{@x2},#{@y2}"
    end
end

def log(matrix, point)
    value = matrix[point]
    value = 0 unless value
    value += 1
    matrix[point] = value
end

def print_intersection_count(matrix)
    # find intersecting points
    intersections = matrix.select { |k,v| v > 1 }
    puts "Found #{intersections.length} intersecting points"
end