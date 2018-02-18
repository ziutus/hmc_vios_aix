#! /usr/bin/env ruby

require 'pp'
require 'erb'
require 'optparse'

$LOAD_PATH << File.dirname(__FILE__)+'/../inc'
require 'HMC/lssvcevents'

app_dir = File.dirname(__FILE__)+'/..'
directory = "../test/dupa"
date = nil
format = 'csv'
report_type = 'all'

OptionParser.new do |opts|

  opts.on('-d', '--directory NAME',  "base directory with all data, default: '#{directory}'") { |v| directory = v }
  opts.on('-D', '--date DATE',  'date and time of collected data')         { |v| date = v }
  opts.on( '--format FORMAT',  'format of report, can be "hmtl" or "csv"') { |v| format = v }
  opts.on( '--type REPORT_TYPE',  'Type of report, can be "all" or "callhome"') { |v| report_type = v }

  opts.on("-h", "--help", "Prints this help") do
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

unless Dir.exist?("#{directory}/#{date}")
  puts "The directory #{directory}/#{date} doesn't exist, exiting..."
  exit 1
end

unless format == 'csv' or format == 'html'
  puts "Unknown format #{format}, you can use only 'html' or 'csv'."
end

events = Lssvcevents.new()
renderer = ERB.new(File.read("#{app_dir}/erb/hmc_check_events_#{format}.erb"))

Dir.chdir("#{directory}/#{date}/")
 Dir.glob('*').sort.select { |hmc_dir|
    Dir[hmc_dir + '/lssvcevents_hardware.txt' ].each { |filename|
        next unless File.exist?(filename)
        data_string = File.read(filename)
        events.parse(data_string, hmc_dir )
    }
 }

events2 = Array.new()
events.events.each_index { |index|

  if report_type == 'all'
    events2.push(events.events[index])
  elsif report_type == 'callhome'
    if events.events[index].callhome_intended == 'true'
      events2.push(events.events[index])
    end
  else
    puts "wrong type of report #{report_type}"
    exit 6
  end
}

puts renderer.result()

exit 0