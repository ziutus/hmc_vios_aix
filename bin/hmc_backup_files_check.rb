#! /usr/bin/env ruby

# own libraries
$LOAD_PATH << File.dirname(__FILE__)+'/../inc'

# standard libraries
require 'pp'
require 'yaml'


options = YAML.load_file('../hmc_data.yaml')

backup_dir = '/var/tmp/'
time_diff_max_expected = 60*60*24*4


hmc_names = Array.new

#pp options["defaults"]["hmcs"]["backup_server"]
#pp options["hmcs"]

options["hmcs"].each do |hmc|
  hmc_names.push( hmc["name"])
end


hmc_missing_dirs = Array.new

pp hmc_names

hmc_names.sort.each do |hmc|

   puts "* Checking HMC #{hmc}"
   hmc_dir = backup_dir + "/" + hmc
   unless Dir.exist?(hmc_dir)
     puts "** Backup directory #{hmc_dir} doesn't exist!"
     next
   end

  puts "**Checking number of files in directory"
  files = Dir["#{hmc_dir}/*"]

  if files.count == 0
    puts "** no backup files!"
    next
  end

  files.each do |file|
    size = File.size(file)
    puts "*** file #{file} has size: " + size.to_s
    if size < 800000
      puts "Size is to small, is it backup?"
    end

    birthdate = File.ctime(file)

    pp birthdate

    
    time_diff = Time.now() - birthdate
    time_diff = time_diff.round(0)

    puts "Diff time is: #{time_diff} seconds, max diff time is #{time_diff_max_expected} seconds"

    if time_diff > time_diff_max_expected
      puts "The backup file #{file} is too old (is backup settings working?)"
    end

  end

end


exit 0