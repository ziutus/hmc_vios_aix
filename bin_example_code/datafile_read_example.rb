#! /usr/bin/env ruby

require 'optparse'
require 'yaml'
require 'net/ssh'
require 'pp'

require_relative 'inc/Framework/MyExec'
require_relative 'inc/Framework/DataFile'

options = {}
options = YAML.load_file('hmc_data.yaml')

execMode="on"

Exec = MyExec.new('ssh', execMode)
Exec.setSsh(options[:hmc], options[:username], options[:password])

File1 = DataFile.new("data/"+options[:hmc]+".txt")

puts File1.Read("lsaccfg -t resourcerole")