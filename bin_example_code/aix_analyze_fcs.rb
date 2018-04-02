#! /usr/bin/env ruby

$LOAD_PATH << File.dirname(__FILE__)+"/../inc"

require 'pp'
#
require 'DataFile3'
require 'AIX/adapter_fc'

# This script should be able to compare statistics of fcs adapters in time.
# TODO: adapter should be called by serial number not by fcs... as by mistake could be taken data from different servers
# TODO: script should also check if reset of counters was done (check 'Seconds Since Last Reset')

file = DataFile3.new("../test/data/fcstats_logdata.txt")

#pp file.ListCommands

fcstat_strings =  file.Read('fcstat fcs0')
fcstats = Array.new

#pp fcstats.class

fc_adapter = Adapter_fc.new

fcstat_strings.count

fcstat_strings.each  {|data_string|
  fc_adapter.fcstat_add(data_string[0], data_string[1])
}

# fc_adapter.analyze

pp fc_adapter.diffs

exit 0