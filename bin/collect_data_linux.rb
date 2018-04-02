#! /usr/bin/env ruby
$LOAD_PATH << File.dirname(__FILE__)+ '/../inc'

# standard libraries
require 'pp'
require 'DataFile3'


server=`uname -n`.chomp
dateTime=Time.now.strftime("%Y%m%d_%H%M%S")

puts server

file = DataFile3.new("/tmp/#{server}_#{dateTime}.datafile.txt")

file.Write('uname -n', `uname -n`)
file.Write('ps -ef', `ps -ef`)
file.Write('free', `free`)



exit 0