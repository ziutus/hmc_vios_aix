#! /usr/bin/env ruby

$LOAD_PATH << File.dirname(__FILE__)+"/inc"

require 'pp'
require 'optparse'

require 'Unix/Ps_ef'

filename = 't/data/linux_2.txt'

OptionParser.new do |opts|

	myName = File.basename(__FILE__)

	opts.banner = "Usage: #{myName} [options]"

  
  opts.on('-f', '--flie FILENAME', 'filename') { |v| filename = v }

  opts.on('-h', '--help', 'show this message') do 
	puts opts 
	exit 1 
  end
  
end.parse!


contents = File.read(filename)

ps = Ps_ef.new(contents)

#pp ps