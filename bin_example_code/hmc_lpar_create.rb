#! /usr/bin/env ruby

# https://www.ibm.com/support/knowledgecenter/en/POWER8/p8hc3/p8hc3_hmcpreprmc.htm

$LOAD_PATH << File.dirname(__FILE__) + '/../inc'

require 'optparse'
require 'yaml'
require 'net/ssh'
require 'pp'

require 'MyExec'
require 'HMC/Lpar_profile'

lpar_name='test1'
lpar_id=10
frame='test'

if lpar_name == ''
	puts "if you want to create lpar, please provide name of lpar!\n "
	puts 'exiting...'
	exit 

end

if lpar_id == 0
	puts 'You should provide the lparID!'
	puts 'Exiting...'
	exit 10
end


vent1 = VirtualEthAdapter.new
vent1.virtualSlotNumber=2
vent1.portVlanID=1

vent2 = VirtualEthAdapter.new
vent2.virtualSlotNumber=3
vent2.portVlanID=2

vscsi1 = VirtualScsiAdapter.new
vscsi1.virtualSlotNumber=4
vscsi1.clientOrServer='client'
vscsi1.remoteLparID=2
vscsi1.remoteLparName='vios1'
vscsi1.remoteSlotNumber=11
vscsi1.isRequired=1

vscsi2 = VirtualScsiAdapter.new
vscsi2.virtualSlotNumber=5
vscsi2.clientOrServer='client'
vscsi2.remoteLparID=3
vscsi2.remoteLparName='vios2'
vscsi2.remoteSlotNumber=12
vscsi2.isRequired=1	

profile = Lpar_profile.new(lpar_id)
profile.name = lpar_name
profile.sys = frame
profile.lpar_id = lpar_id
profile.lpar_name = lpar_name
profile.adapter_add(vent1)
profile.adapter_add(vent2)

profile.adapter_add(vscsi1)
profile.adapter_add(vscsi2)

puts profile.mksyscfg_cmd


exit 0