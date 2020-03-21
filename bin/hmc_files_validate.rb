#! /usr/bin/env ruby

require 'pp'
require 'erb'
require 'optparse'

$LOAD_PATH << File.dirname(__FILE__) + '/../lib'

require 'HMC/Sys'
require 'Framework/hmcDir'
require 'Framework/HmcLpar'
require 'Framework/system'

directory = '/tmp/hmc/'
date = nil
report_type = 'all'
verbose = 0
errors = 0

OptionParser.new do |opts|
 # opts.on('-d', '--directory NAME', "base directory with all data, default: '#{directory}'") { |v| directory = v }
 # opts.on('-D', '--date DATE', 'date and time of collected data')         { |v| date = v }
  opts.on('--type REPORT_TYPE', 'Type of report, can be "all" or "callhome"') { |v| report_type = v }
#  opts.on('--verbose LEVEL', Integer, 'Level of verbose of script') { |v| verbose = v }

  opts.on('-h', '--help', 'Print this help') do
    puts opts
    exit
  end
end.parse!

# -W0, -W1 and -W2 for $VERBOSE
#pp $VERBOSE
#pp $DEBUG
#exit 0

if date.nil?
  puts "The 'date' is not provided, please use --help to see options, exiting..."
  exit 4
end

Dir.chdir(directory + '/' + date + '/')
Dir.glob('*').select {|hmc|
  puts hmc
  next unless File.directory? hmc

  hmc_data = HmcDir.new(directory + '/' + date + '/' + hmc)
  hmc_data.verbose = verbose

  pp hmc_data.validate
  pp hmc_data.errors
  pp hmc_data.warnings

  pp hmc_data.sys

  hmc_data.sys.each do |sys_name|
    sys = System.new(sys_name)
    sys.parse_raw_data(hmc_data.file_content(sys_name, 'lpar_info'))

    pp sys.lpars_by_name
  end

}

exit errors