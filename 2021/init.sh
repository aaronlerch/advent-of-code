echo '#!/usr/bin/env ruby

INPUT_FILE = "input.txt"
input = File.readlines(INPUT_FILE).map(&:chomp)
' > $1

chmod +x $1