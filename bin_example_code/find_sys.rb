#! /usr/bin/env ruby

require 'pp'
require 'erb'
require 'optparse'

$LOAD_PATH << File.dirname(__FILE__) + '/../inc'

require 'Framework/framework_data'

directory = '/mnt/c/git/hmc_vios_aix2/data'
#directory = 'c:\git\hmc_vios_aix2\data'
config_file = '../main_config.yaml'
date = '20180603_1656'
verbose = 0
errors = 0
sys_to_find = '9131-52A-6535CCG'

OptionParser.new do |opts|
  opts.on('-d', '--directory NAME', "base directory with all data, default: '#{directory}'") { |v| directory = v }
  opts.on('-D', '--date DATE', 'date and time of collected data')         { |v| date = v }
  opts.on('-F', '--frame FRAME_TO_FIND', 'name of frame to find')         { |v| sys_to_find = v }
  opts.on('--verbose LEVEL', Integer, 'Level of verbose of script') { |v| verbose = v }

  opts.on('-h', '--help', 'Print this help') do
    puts opts
    exit
  end
end.parse!

if date.nil?
  puts "The 'date' is not provided, please use --help to see options, exiting..."
  exit 4
end

puts "Frame to find: >#{sys_to_find}<"

hmc_data = FrameworkData.new(directory, date, config_file)
hmc_data.verbose = verbose
frames = hmc_data.search_frame(sys_to_find)

frames.each do |frame|
  puts frame.name + ":" + frame.hmc
end

exit errors