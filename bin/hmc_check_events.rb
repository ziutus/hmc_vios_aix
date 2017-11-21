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


OptionParser.new do |opts|

  opts.on('-d', '--directory NAME',  "base directory with all data, default: '#{directory}'") { |v| directory = v }
  opts.on('-D', '--date DATE',  'date and time of collected data')         { |v| date = v }
  opts.on( '--format FORMAT',  'format of report, can be "hmtl" or "csv"') { |v| format = v }

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
 Dir.glob('*').select { |hmc_dir|
    Dir[hmc_dir + '/lssvcevents_hardware.txt' ].each { |filename|
        next unless File.exist?(filename)
        data_string = File.read(filename)
        events.parse(data_string, hmc_dir )
    }
 }

#events.events.each_with_index {|event, id|
#     events.events.delete_at(id) unless event.callhome_intended == 'true'
#}

puts renderer.result()

exit 0