#! /usr/bin/env ruby

# own libraries
$LOAD_PATH << File.dirname(__FILE__)+'/../inc'

# standard libraries
require 'pp'
require 'optparse'
require 'net/ping'
#require 'dnsruby'
#include Dnsruby
require 'yaml'


require 'HMC/Hmc_upgrade'
require 'MyExec'
require 'HMC/Version'

options = YAML.load_file('../hmc_data.yaml')

exec_mode='on'


execute = MyExec.new('ssh', exec_mode)
execute.set_ssh(options[:hmc], options[:username], options[:password])

def up?(host)
  check = Net::Ping::External.new(host)
  check.ping?
end


#test if HMC is up and pingable
unless up?(options[:hmc])
  puts "the HMC #{options[:hmc]} is not up, exiting..."
  exit 2
end


#test if you can ssh to ssh
whoami = execute.execute('whoami')
if (whoami != options[:username])
  puts "problem with ssh, exiting..."
  exit 3
end


# test if HMC is able to ping ftp server


# test if HMC version is correct
version = Version.new
version.parse(execute.execute(version.version_cmd))
STDOUT.sync = true

pp version

if (version.release == '7.9.0' and version.servicePack.to_i < 1 )

  STDOUT.sync = true

  cmd = HmcUpgrade.new
  cmd.hostname = '192.168.200.20'
  cmd.user = 'ziutus'
  cmd.password = 'zuuz00zuuz'
  cmd.filename = '/hmc/HMC_Update_V7R790_SP1.iso'
  cmd.reboot = true

  pp cmd.cmd
  execute.execute(cmd.cmd)
else
  pp 'update is not needed'
end

exit 0