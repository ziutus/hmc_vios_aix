#! /usr/bin/env ruby
$LOAD_PATH << File.dirname(__FILE__)+ '/../inc'

# standard libraries
require 'pp'

# own libraries
require 'DataFile3'

file = DataFile3.new("../test/data/fcstats_logdata.txt")

pp file.ListCommands

#pp file.Read('fcstat fcs0')



exit 0