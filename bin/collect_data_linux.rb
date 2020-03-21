#! /usr/bin/env ruby
$LOAD_PATH << File.dirname(__FILE__) + '/../lib'

# standard libraries
require 'pp'
require 'optparse'

# own libraries
require 'Framework/DataFile3'

# Variables
dateTime=Time.now.strftime("%Y%m%d_%H%M%S")


OptionParser.new do |opts|
  opts.on('--date YYYMMDD-HHMM', 'date of report') { |v| dateTime = v }
end.parse!


server=`uname -n`.chomp
filename = "/tmp/#{server}_#{dateTime}.datafile.txt"

puts server

file = DataFile3.new(filename)

file.Write('uname -n', `uname -n`, true)
file.Write('ps -ef', `ps -ef`, true)
file.Write('free', `free`, true)
file.Write('df -P --local', `df -P --local`, true)
file.Write('df -P --local -H', `df -P --local -H`, true)

puts "Data have been written to file #{filename}"

exit 0