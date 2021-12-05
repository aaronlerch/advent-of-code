#!/usr/bin/env ruby

# read each line, if increased, increment counter (if no previous, ignore)

prev = nil
increases = 0

File.readlines("input.txt").each do |line|
  depth = line.to_i
  unless prev == nil
    increases += 1 if depth > prev
  end
  prev = depth
end

puts "Increases: #{increases}"
