#! /usr/bin/env ruby

require 'pp'
require 'erb'
require 'optparse'

$LOAD_PATH << File.dirname(__FILE__) + '/../inc'
require 'HMC/lssvcevents'

app_dir = File.dirname(__FILE__) + '/..'
directory = '../data'
date = nil
format = 'csv'
report_type = 'all'
verbose = 0
hmcNotWorking = []

OptionParser.new do |opts|

  opts.on('-d', '--directory NAME', "base directory with all data, default: '#{directory}'") { |v| directory = v }
  opts.on('-D', '--date DATE', 'date and time of collected data')         { |v| date = v }
  opts.on( '--format FORMAT', 'format of report, can be "hmtl" or "csv"') { |v| format = v }
  opts.on( '--type REPORT_TYPE', 'Type of report, can be "all" or "callhome"') { |v| report_type = v }
  opts.on( '--verbose LEVEL', Integer, 'Level of verbose of script') { |v| verbose = v }

  opts.on('-h', '--help', 'Prints this help') do
    puts opts
    exit
  end
end.parse!

if date.nil?
  puts "The 'date' is not provided, please use --help to see options, exiting..."
  exit 4
end

unless Dir.exist?(directory)
  puts "Base directory #{directory} doesn't exist, exiting..."
  exit 1
end

unless Dir.exist?("#{directory}/#{date}/hmc/")
  puts "The directory #{directory}/#{date}/hmc/ doesn't exist, exiting..."
  exit 1
end

unless format == 'csv' or format == 'html'
  puts "Unknown format #{format}, you can use only 'html' or 'csv'."
end

events = Lssvcevents.new
renderer = ERB.new(File.read("#{app_dir}/erb/hmc_check_events_#{format}.erb"))

Dir.chdir("#{directory}/#{date}/hmc/")
Dir.glob('*').sort.select do |hmc_dir|
  puts ">Checking HMC #{hmc_dir}<" if verbose > 0
  Dir[hmc_dir + '/lssvcevents_hardware.txt' ].each do |filename|
    unless File.exist?(filename)
      puts ">File #{filename} doesn't exist"
      next
    end

    data_string = File.read(filename)

    if data_string =~ /An unknown error occurred while trying to perform this command. Retry the command. If the error persists, contact your software support representative./
      hmcNotWorking.push(hmc_dir)
      next
    end
    events.parse(data_string, hmc_dir )
  end
end

events2 = []
events.events.each_index do |index|

  if report_type == 'all'
    events2.push(events.events[index])
  elsif report_type == 'callhome'
    if events.events[index].callhome_intended == 'true'
      puts "Adding to events2 the #{events.events[index].problem_num} as 'call home' setup for 'true' " if verbose > 0
      events2.push(events.events[index])
    else
      puts "Ignoring event #{events.events[index].problem_num} as 'call home' setup for 'false' " if verbose > 0
    end
  else
    puts "wrong type of report #{report_type}"
    exit 6
  end
end

puts renderer.result
puts 'Found issue with collecting data from below HMCs:' + hmcNotWorking.join(',').to_s

exit 0