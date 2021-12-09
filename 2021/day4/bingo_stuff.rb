class Board
    attr_reader :entries, :board_number, :last_marked_number

    def initialize(grid, board_number)
        # expecting a 5x5 grid of numbers, turn them into Entry's
        @entries = grid.map { |row| row.map { |cell| Entry.new(cell) } }
        @board_number = board_number
    end

    def mark_number(number)
        @entries.each do |row|
            row.each do |cell|
                if cell.number == number
                    cell.marked = true
                    @last_marked_number = number
                end
            end
        end
    end

    def winner?
        # look for all entries in a given row, or column, but not diagonal
        # iterate the rows, transpose, repeat, exit if you find a winning row or column
        iterations = [@entries, @entries.transpose]
        iterations.each do |data|
            data.each do |row|
                if row.select { |cell| cell.marked }.length == row.length
                    return true
                end
            end
        end

        return false
    end

    def score
        # get unmarked numbers
        unmarked = @entries.map { |row| row.select { |cell| !cell.marked? } }
        sum = unmarked.flatten.map { |e| e.number }.sum

        sum * @last_marked_number
    end

    def to_s
        result = "BOARD NUM: #{@board_number} | LAST MARKED: #{@last_marked_number} | SCORE: #{score}\n"
        @entries.each do |row|
            row.each do |cell|
                result << cell.to_s.rjust(4) << " "
            end
            result << "\n"
        end
        result
    end

private
    def mark(x,y)
        @entries[x][y].marked = true
    end
end

class Entry
    attr_reader :number
    attr_accessor :marked

    def initialize(number)
        @number = number
    end

    def marked?
        @marked
    end

    def to_s
        if @marked
            "[#{@number.to_s}]"
        else
            @number.to_s
        end
    end
end