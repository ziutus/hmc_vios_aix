#! /usr/bin/env ruby

require 'optparse'
require 'pp'

require_relative('../inc/ibm_case')
require_relative('../inc/HashFromCsv')

include HashFromCsv

config_file = 'config.txt'
datacenter_file = '/tmp/datacenter_info.csv'

raise "The config file: #{config_file} doesn't exit" unless File.exist?(config_file)

id = ARGV.shift
raise 'The ID of case in IBM has not provided' if id.nil?

ibm_case = IbmCase.new (id)

if /^\w{5}$/.match(id)
  print "Please provide Data Center name:"
  datacenter = STDIN.gets.chomp

  datacenters = HashFromCsv::parseCsvToHash(File.read(datacenter_file))

  print "Searching info about branch ID and country for DataCenter >#{datacenter}< ..."
  if datacenters.key?(datacenter)
    puts "found [OK]"

    ibm_case.branch_id    = datacenters[datacenter]['branch']
    ibm_case.country_code = datacenters[datacenter]['country']

  else
    puts "not found {failed!]"

    print "Please provide branche ID (xxx):"
    ibm_case.branch_id = STDIN.gets.chomp
    print "Please provide country code (yyy):"
    ibm_case.country_code = STDIN.gets.chomp
  end

end

files = ARGV

raise 'No files provided' if files.empty?

STDOUT.sync = true
command = "ibmsdduu -config=#{config_file} " + ibm_case.to_ibmsdduu  +  ' ' + files.join(' ')

# http://mentalized.net/journal/2010/03/08/5-ways-to-run-commands-from-ruby/
puts "I will call command:"
puts command
puts "Is it ok? [Yn]"
answer = STDIN.gets.chomp
if answer == '' or answer == 'Y' or answer == 'y'
  exec(command)
else
  puts "As requested, I'm not executing command... exiting..."
end

exit(0)