class MapExpander
    class << self
        def expand(grid)
            new_grid = deep_copy(grid)

            # Expand first row of tiles horizontally
            copy = deep_copy(new_grid)
            4.times do |horiz|
                increment_all(copy)
                new_grid.each_with_index do |row, i|
                    row.push(*copy[i])
                end
            end

            # new_grid now has 5 tiles across, we need to add 4 more rows to get 5x5
            copy = deep_copy(new_grid)
            4.times do |vert|
                increment_all(copy)
                # create a copy of the copy because appending the rows
                # will maintain originals
                appending_copy = deep_copy(copy)
                # append all copy rows
                appending_copy.each do |row|
                    new_grid << row
                end
            end

            new_grid
        end

        def increment_all(grid)
            grid.each do |row|
                row.each_with_index do |cell, i|
                    row[i] = increment(cell)
                end
            end
            return grid
        end

        def increment(digit)
            digit += 1
            digit = 1 if digit > 9
            digit
        end

        def deep_copy(grid)
            new_grid = []
            grid.each do |row|
                new_grid << row.dup
            end
            new_grid
        end
    end
end