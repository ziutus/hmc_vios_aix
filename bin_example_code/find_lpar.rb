#! /usr/bin/env ruby

require 'pp'
require 'erb'
require 'optparse'

$LOAD_PATH << File.dirname(__FILE__) + '/../lib'

require 'Framework/framework_data'

directory = File.join(Dir.pwd, '..', 'data')
config_file = '../main_config.yaml'
date = '20180603_1656'
verbose = 0
errors = 0
lpar_to_find = 'nim1'

OptionParser.new do |opts|
  opts.on('-d', '--directory NAME', "base directory with all data, default: '#{directory}'") { |v| directory = v }
  opts.on('-D', '--date DATE', 'date and time of collected data')         { |v| date = v }
  opts.on('-L', '--lpar LPAR_TO_FIND', 'name of lpar to find')         { |v| lpar_to_find = v }
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

puts "Lpar to find: >#{lpar_to_find}<"

hmc_data = FrameworkData.new(directory, date, config_file)
hmc_data.verbose = verbose
lpars = hmc_data.search_lpar(lpar_to_find)

lpars.each do |lpar|
  pp lpar.hmc
  pp lpar.sys
  pp lpar.name
  pp lpar.vioses
#  pp lpar.npiv
#  pp lpar.vscsi.to_s
end

exit errors