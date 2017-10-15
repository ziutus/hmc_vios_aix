#! /usr/bin/env ruby

$LOAD_PATH << File.dirname(__FILE__) + './inc'

require 'optparse'
require 'yaml'
require 'net/ssh'
require 'pp'

require_relative 'inc/nc/MyExec'
require_relative 'inc/HMC/Sys'
#require_relative 'inc/HMC/HmcString'
require_relative 'inc/HMC/Lpar_real'
require_relative 'inc/HMC/Lpar_profile'

require_relative 'inc/HMC/VirtualEthAdapter'
require_relative 'inc/HMC/VirtualScsiAdapter'

lparName="test1"
lparID=10
frame="test"

if lparName == ""
	puts "if you want to create lpar, please provide name of lpar!\n "
	puts "exiting..."
	exit 

end

if lparID == 0
	puts "You should provide the lparID!"
	puts "Exiting..."
	exit 10
end


vent1 = VirtualEthAdapter.new()
vent1.virtualSlotNumber=2
vent1.portVlanID=1

vent2 = VirtualEthAdapter.new()
vent2.virtualSlotNumber=3
vent2.portVlanID=2

vscsi1 = VirtualScsiAdapter.new()
vscsi1.virtualSlotNumber=4
vscsi1.clientOrServer="client"
vscsi1.remoteLparID=2
vscsi1.remoteLparName="vios1"
vscsi1.remoteSlotNumber=11
vscsi1.isRequired=1

vscsi2 = VirtualScsiAdapter.new()
vscsi2.virtualSlotNumber=5
vscsi2.clientOrServer="client"
vscsi2.remoteLparID=3
vscsi2.remoteLparName="vios2"
vscsi2.remoteSlotNumber=12
vscsi2.isRequired=1	

lpar = Lpar_profile.new(lparID)
lpar.name = lparName
lpar.sys = frame
lpar.adapter_eth_add(vent1)
lpar.adapter_eth_add(vent2)

lpar.virtual_slots.adapter_scsi_add(vscsi1)
lpar.adapter_scsi_add(vscsi2)

#puts Exec.Exec(lpar.get_mksyscfg)
puts lpar.get_mksyscfg


exit 0