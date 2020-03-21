#! /usr/bin/env ruby

$LOAD_PATH << File.dirname(__FILE__)+"/inc"
$LOAD_PATH << File.dirname(__FILE__) + '/../inc'


require 'pp'
require 'optparse'

require 'Unix/uptime'

dirname = 'test/data/uptime'

OptionParser.new do |opts|

  myName = File.basename(__FILE__)

  opts.banner = "Usage: #{myName} [options]"


  opts.on('-d', '--dir DIRNAME', 'dirname') { |v| dirname = v }

  opts.on('-h', '--help', 'show this message') do
    puts opts
    exit 1
  end

end.parse!

puts "Dirname is: #{dirname}"

Dir["#{dirname}/*"].each do |filename|
  puts "* Filename: #{filename}"
  puts "* Filename short: " + File.basename(filename, ".txt")
  puts File.read(filename)
  uptime = Uptime.new(File.read(filename))
  puts "#{uptime.load_1} #{uptime.load_5} #{uptime.load_15}"
end

# contents = File.read(dirname)
# ps = Ps_ef.new(contents)

# pp ps