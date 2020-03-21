#! /usr/bin/env ruby

require 'pp'
require 'erb'
require 'optparse'
require 'date'

$LOAD_PATH << File.dirname(__FILE__) + '/../lib'

require 'Framework/framework_data'
require 'Framework/DataFile'
require 'Framework/lpar'
require 'VIOS/Vhost'
require 'VIOS/Vtd'
require 'VIOS/lsmap'


# This script creating example data for tests
# test data source (but modified): http://blog.sekratech.de/2014/05/28/change-on-the-fly-vio-fc-mapping-because-of-problem-with-live-partition-mobility/


vioses = { 1 => 'vios1', 2 => 'vios2' }
date = '20180604_1656'
data_dir = '../test/data/'
hdisk_number = 3

fdata = FrameworkData.new(data_dir, date)
fdata.verbose = 1
fdata.create_structure(data_dir)

# creating HMC data (list of frame, etc)
filename = "#{data_dir}/hmc/#{date}/lssyscfg_r_sys_F_name_serial_num_state.txt"
if File.exist?(filename)
  File.open(filename, 'w') { |file| file.truncate(0) }
end
File.write(filename, '9131-52A-6535CCG,6535CCG,Operating')

lpars = { 5 => 'nim1', 6 => 'lapr_4', 7 => 'lpar_5'}

# lpars.each_pair do |id, name|
#   lpar = Lpar.new
#   lpar.lpar_id = id
#   lpar.name = name
#   pp lpar.to_s
# end

exit 0

vioses.each_pair do |vios_id, viosname|
  vfchost_id = 0
  hdisk_id = 2
  string = ''
  lsmap = Lsmap.new

  lpars.each_key do |lpar_id|

    puts "LparID: #{lpar_id}"
    string += "vfchost#{vfchost_id}:U9117.MMB.xxxxxxx-V#{vios_id}-C#{vfchost_id+1}:#{lpar_id}:" + lpars[lpar_id] + ":AIX:LOGGED_IN:fcs0:U78C0.001.DBJN321-P2-C5-T1:5:a:fcs0:U9117.MMB.06xxxxx-V#{lpar_id}-C#{lpar_id}\n"
    string += "vfchost#{vfchost_id+1}:U9117.MMB.xxxxxxx-V#{vios_id}-C#{vfchost_id+2}:#{lpar_id}:"  + lpars[lpar_id] +  ":AIX:LOGGED_IN:fcs1:U78C0.001.DBJN321-P2-C5-T2:3:a:fcs1:U9117.MMB.06xxxxx-V#{lpar_id}-C#{lpar_id+1}\n"
    vfchost_id += 2

    vhost = Vhost.new
    vhost.name = "vhost#{lpar_id - 5}"
    vhost.physloc = "U787A.001.0397658-V#{vios_id}-C#{lpar_id}"
    vhost.client_partition_id = "0x0000000#{lpar_id}"

    1.step(hdisk_number) do |id|
      vtd = Vtd.new
      vtd.name = "c#{lpar_id}_vtscsi#{id}"
      vtd.status = 'Available'
      vtd.lun = "0x8#{id}00000000000000"
      vtd.backing_device = 'hdisk' + hdisk_id.to_s
      hdisk_id += 1

      vhost.vtds.push(vtd)
    end
    lsmap.mapping[vhost.name] = vhost
  end

  datafile = DataFile.new("#{data_dir}/vios/#{date}/#{viosname}.txt")
  datafile.make_empty

  datafile.write('uname -n', viosname)
  datafile.write('date +"%s"', DateTime.strptime(date, '%Y%m%d_%H%M').strftime("%s"))
  datafile.write('lsmap -npiv -all -fmt :', string)
  datafile.write('lsmap -all', lsmap.to_s_long_fixed)
  datafile.write('echo "---end---"', '---end---')

end

exit 0