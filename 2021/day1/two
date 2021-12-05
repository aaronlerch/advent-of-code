#!/usr/bin/env ruby

# window function over 3 data points
DATA_POINTS_PER_WINDOW = 3
sums = []
window = []

File.foreach("input.txt").with_index do |line, i|
  depth = line.to_i
  window << depth
  if window.length == DATA_POINTS_PER_WINDOW
    sums << window.sum
    window.shift # pops the first item
  end
end

increases = 0
prev = nil
sums.each do |value|
  if prev && value > prev
    increases += 1
  end
  prev = value
end

puts "Increases: #{increases}"