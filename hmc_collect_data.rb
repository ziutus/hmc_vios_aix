#! /usr/bin/ruby

require 'optparse'
require 'yaml'
require 'net/ssh'
require 'pp'

require_relative 'inc/MyExec'
require_relative 'inc/DataFile'

#TODO: script should first check if config file exist, if not should ask about connection data and  create it if permited (if user want)
#TODO: script shoud be able to collect data from more then one HMC, confnig file should build array and HMC should be key for each entry

options = YAML.load_file('hmc_data.yaml')

dataDir = 'data'

Exec = MyExec.new('ssh', "on")

#TODO: in case HMC is down or ssh is not working, script should go to next HMC or end if it is last
#TODO: script should check if it is HMC, if not should report issue and go to next HMC (lshmc -v will give answer if exist)
Exec.setSsh(options[:hmc], options[:username], options[:password])

filename = dataDir + '/' +options[:hmc] + '.' + Time.now.strftime('%Y%m%d_%H%M').to_s + '.txt'
file = DataFile.new(filename)

file.Write('who -b', Exec.Exec('who -b'))
file.Write('lshmc -V', Exec.Exec('lshmc -V'))
file.Write('lshmc -v', Exec.Exec('lshmc -v'))
file.Write('lshmc -r', Exec.Exec('lshmc -r'))
file.Write('lshmc -n', Exec.Exec('lshmc -n'))
file.Write('lsaccfg -t taskrole', 		Exec.Exec('lsaccfg -t taskrole'))
file.Write('lsaccfg -t resourcerole', 	Exec.Exec('lsaccfg -t resourcerole'))
file.Write('lshmcusr', 	Exec.Exec('lshmcusr'))
file.Write('lssvcevents -t hardware --filter "status=open"', 	Exec.Exec('lssvcevents -t hardware --filter "status=open"'))
file.Write('lssyscfg -r sys', 				Exec.Exec('lssyscfg -r sys'))


framestring=Exec.Exec('lssyscfg -r sys -F name')
frames=framestring.split("\n")
frames.each { |frame|
  if frame == 'No results were found.'
		puts '"Empty HMC - No frames found...'
		break
	end
	puts "Taking data about frame: #{frame}" 
	file.Write("lssyscfg -r prof #{frame}", 				Exec.Exec("lssyscfg -r prof #{frame}"))
	file.Write("lshwres -r mem --level lpar -m #{frame}", 	Exec.Exec("lshwres -r mem --level lpar -m #{frame}"))
	file.Write("lshwres -r proc --level lpar -m #{frame}", Exec.Exec("lshwres -r proc --level lpar -m #{frame}"))
	
	file.Write("lshwres -r virtualio --level lpar --rsubtype slot -m #{frame}",   Exec.Exec("lshwres -r virtualio --level lpar --rsubtype slot -m #{frame}"))
	file.Write("lshwres -r virtualio --level lpar --rsubtype serial -m #{frame}", Exec.Exec("lshwres -r virtualio --level lpar --rsubtype serial -m #{frame}"))
	file.Write("lshwres -r virtualio --level lpar --rsubtype fc -m #{frame}",     Exec.Exec("lshwres -r virtualio --level lpar --rsubtype fc -m #{frame}"))
	file.Write("lshwres -r virtualio --level lpar --rsubtype eth -m #{frame}",    Exec.Exec("lshwres -r virtualio --level lpar --rsubtype eth -m #{frame}"))
	file.Write("lshwres -r virtualio --level lpar --rsubtype scsi -m #{frame}",   Exec.Exec("lshwres -r virtualio --level lpar --rsubtype scsi -m #{frame}"))

  #TODO: add information about profiles, in case of HMC upgarde, should be checked if are any lpars without profile or without default profile

}

puts 'All data have been written to file' + filename

exit(0)