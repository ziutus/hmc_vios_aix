#! /usr/bin/env ruby
$LOAD_PATH << File.dirname(__FILE__) + '/../inc'

# standard libraries
require 'pp'
require 'Framework/DataFile3'


server=`uname -n`.chomp
dateTime=Time.now.strftime("%Y%m%d_%H%M%S")
filename = "/tmp/#{server}_#{dateTime}.datafile.txt"

puts server

file = DataFile3.new(filename)

file.Write('uname -n', `uname -n`)
file.Write('ps -ef', `ps -ef`)
file.Write('free', `free`)
file.Write('df -P --local', `df -P --local`)
file.Write('df -P --local -H', `df -P --local -H`)

puts "Data have been written to file #{filename}"

exit 0