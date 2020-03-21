#! /usr/bin/env ruby

require 'pp'
require 'erb'
require 'optparse'
require 'socket'
require 'pathname'

$LOAD_PATH << File.dirname(__FILE__) + '/../lib'
require 'HMC/lssvcevents'

app_dir = File.dirname(__FILE__) + '/..'
directory = '../data'
date = nil
format = 'csv'
report_type = 'all'
verbose = 0
links_file = 'hmc_events_links.cvs'
links = {}
csv_file = nil
csv_file_whole = nil
hmc_not_working = []

OptionParser.new do |opts|
  opts.on('-d', '--directory NAME', "base directory with all data, default: '#{directory}'") { |v| directory = v }
  opts.on('-D', '--date DATE', 'date and time of collected data')         { |v| date = v }
  opts.on('--format FORMAT', 'format of report, can be "hmtl" or "csv"') { |v| format = v }
  opts.on('--type REPORT_TYPE', 'Type of report, can be "all" or "callhome"') { |v| report_type = v }
  opts.on('--verbose LEVEL', Integer, 'Level of verbose of script') { |v| verbose = v }
  opts.on('--linksfile FILENAME', 'Links file') { |v| links_file = v }
  opts.on('--csv-file FILENAME', 'csv file') { |v| csv_file = v }
  opts.on('--type REPORT_TYPE', 'Type of report, can be "all" or "callhome"') { |v| report_type = v }


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
  exit 2
end

unless %w[csv html].include?(format)
  puts "Unknown format #{format}, you can use only 'html' or 'csv'."
  exit 3
end

unless %w[all callhome].include?(report_type)
  puts "Unknown report type #{report_type}, you can use only 'all' or 'callhome'."
  exit 4
end

linksfilewhole = links_file

if File.file?(links_file) && File.exist?(links_file)
  linksfilewhole = Pathname.new(links_file).realpath.to_s

  puts 'Link file exist, creating table' if verbose > 0
  File.foreach(links_file).with_index do |line, line_num|
    data = line.split(';')
    links[data[0]] = { refcode: data[0], link: data[1], hint: data[2] }
  end
else
  puts "Link file doesn't exist" if verbose > 0
  end

if ! csv_file.nil? && File.file?(csv_file) && File.exist?(csv_file)
  csv_file_whole = Pathname.new(csv_file).realpath.to_s
  puts 'csv file exist' if verbose > 0
else
  puts "csv file doesn't exist"
  exit 7
end

events = Lssvcevents.new
renderer = ERB.new(File.read("#{app_dir}/erb/hmc_check_events_#{format}.erb"))

Dir.chdir("#{directory}/#{date}/hmc/")
Dir.glob('*').sort.select do |hmc_name|
  puts ">Checking HMC #{hmc_name}<" if verbose > 0
  Dir[hmc_name + '/lssvcevents_hardware.txt'].each do |filename|
    unless File.exist?(filename)
      puts ">File #{filename} doesn't exist"
      next
    end

    data_string = File.read(filename)

    if data_string =~ /An unknown error occurred while trying to perform this command. Retry the command. If the error persists, contact your software support representative./
      hmc_not_working.push(hmc_name)
      next
    end
    events.parse(data_string, hmc_name)
  end
end


events.parse_csv(File.read(csv_file_whole)) unless csv_file_whole.nil?

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
  end
end

puts renderer.result

if hmc_not_working.count > 0
  puts 'Found issue with collecting data from below HMCs:' + hmc_not_working.join(',').to_s
end

exit 0