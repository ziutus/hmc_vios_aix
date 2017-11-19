#! /usr/bin/env ruby

require 'optparse'
require 'pp'

require_relative('../inc/ibm_case')

config_file = 'config.txt'
ibm_case = IbmCase.new (ARGV.shift)
files = ARGV

#raise 'The ID of case in IBM has not provided' if id.nil?
raise "The config file: #{config_file} doesn't exit" unless File.exist?(config_file)
raise 'No files provided' if files.empty?

STDOUT.sync = true
command = "ibmsdduu -config=#{config_file} " + ibm_case.to_ibmsdduu  +  ' ' + files.join(' ')

# http://mentalized.net/journal/2010/03/08/5-ways-to-run-commands-from-ruby/
pp command

exit(0)