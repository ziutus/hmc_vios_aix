#! /usr/bin/ruby

require 'optparse'
require 'yaml'
require 'net/ssh'
require 'pp'


require_relative 'inc/MyExec'
require_relative 'inc/HMC/Sys'
require_relative 'inc/HMC/Lpar_real'
require_relative 'inc/HMC/Lpar_profile'

require_relative 'inc/HMC/VirtualEthAdapter'
require_relative 'inc/HMC/VirtualScsiAdapter'

require_relative 'inc/HMC/TaskRoles'

myName = File.basename(__FILE__)

options = {}
options = YAML.load_file('hmc_data.yaml')

action=""
defaultAction="statusAll"
frame=""
lparName=""
lparID=0
execMode="on"


def help_message

	description="
Usage: #{$myName} [opotions]
	
	-m machine 
	
	
	possible ACTION: 
	on|off - powerOn or powerOff frame or lpar
	status|statusAll - show status of Frame or lpar
	lparCreate - create lpar using default values
	exec on|off - on - run all commands, off - run only commands for collecting data	
	
Examples:
	#{$myName} -a statusAll - show status of all frames (list frames and status)	
	
	"

	puts description
	
	exit
end 


OptionParser.new do |opts|

	# puts "HERE!"
	# pp opts 

  opts.banner = "Usage: #{myName} [options]"

    ACTION_DESCRIPTION  = "
	possible ACTION: 
	on|off - powerOn or powerOff frame or lpar
	status|statusAll - show status of Frame or lpar
	lparCreate - create lpar using default values
	exec on|off - on - run all commands, off - run only commands for collecting data
	"  
  
  opts.on('-s', '--hmc NAME',  'server name') { |v| options[:hmc] = v }
  opts.on('-u', '--username USER', 'user name') { |v| options[:username] = v }
  opts.on('-p', '--password PASSWORD', 'user password') { |v| options[:password] = v }
  opts.on('-F', '--frame FRAME', 'frame name') { |v| frame = v }
  opts.on('-m', '--machine FRAME', 'frame name') { |v| frame = v }
  opts.on('-l', '--lpar LPAR', 'lpar name') { |v| lparName = v }
  opts.on('-i', '--lparID LPARID', 'lpar id') { |v| lparID = v }
  opts.on('-E', '--Exec on|off', 'on|off') { |v| execMode = v  }
  
  opts.on('-a', "--action ACTION  ", 'action ') { |v| 
	action = v
  }

  opts.on('-h', '--help', 'show this message') do 
	puts opts 
	exit 1 
  end
  
end.parse!


#puts "action:  " + action.inspect
#puts "execMode:" + execMode.to_s


if action == "" || action == nil 
	action = defaultAction
end

if action == "lparCreate" and lparName == ""
	puts "if you want to create lpar, please provide name of lpar!\n "
	puts "exiting..."
	exit 

end

	if action == "lparCreate" and lparID == 0
		puts "You should provide the lparID!"
		puts "Exiting..."
		exit 10
	end

Frame = Sys.new(frame)

Exec = MyExec.new('ssh', execMode)
Exec.setSsh(options[:hmc], options[:username], options[:password])

####
#
####
####
def startFrameAndCheckProgress frameName

	 frame = Sys.new(frameName)
	 puts "Checking status of Frame"
	 frameStatus = Exec.Exec(Frame.statusCheck(), "on").gsub("\n", '')	
	 puts frameStatus.to_s + "Frame startTime: " + Frame.startTime.to_s

	 if   frameStatus == "Power Off"
		puts "Frame status is not funny: #{$frameStatus}"
		puts "Starting the frame, will wait " + Frame.startTime.to_s + " seconds"
		Exec.Exec(Frame.start())
		maxIteration=5
		for i in 1..maxIteration=5
			sleep Frame.startTime.to_i
			frameStatus = Exec.Exec(Frame.statusCheck(), "on").gsub("\n", '')	
			break if frameStatus == "Operating"
			puts "i form: " + maxIteration.to_s + " "+i.to_s
			puts frameStatus
		end	
	end

	if frameStatus  == "Initializing"
		puts "Frame is starting"
		puts "Waiting " + Frame.startTime + " seconds"
		sleep Frame.startTime.to_i 	
	end
	
	 frameStatus = Exec.Exec(Frame.statusCheck(), "on").gsub("\n", '')	
	 if   frameStatus == "Power Off"
		puts "Can't start the Frame, status of frame "+frameStatus
		exit 0	
	end 

end



#puts "lpar: #{lparName} "

if lparName.size > 0
#	puts "lpar1:"+lparName.size.to_s
	
	case action
		when 'on'
			action='lparOn'
		when 'off'
			action='lparOff'
	end	
end


case action

  when "ListTaskRoles"
	puts "Listing Task Roles on HMC"
    HMC = TaskRoles.new()
    TaskRolesList = Exec.Exec(HMC.getTaskRolesList()).split("\n")
	p TaskRolesList

  when "TaskRoleAdd"
	puts "Listing Task Roles on HMC"
    HMC = TaskRoles.new()
    TaskRolesList = Exec.Exec(HMC.getTaskRolesList()).split("\n")
	
	Name="test2"
	
	if TaskRolesList.include? Name 
		puts "can't add new taskrole as it exist on this HMC"
	else
		puts "I will add taskrole to this HMC"
	end
	
	
  when "on"
	puts "Will power on the frame"
	puts Frame.start()
	puts Exec.Exec(Frame.start())

  when "status"
	puts "Will check status of frame"
	puts Frame.statusCheck()
	puts Exec.Exec(Frame.statusCheck())
	
  when "statusAll"
	puts "Will check status of frame (All data)"
	puts Frame.dataGet()
	DataString = Exec.Exec(Frame.dataGet()) 
	
	Frame.decodeString(DataString)
	
	puts Frame.name + " State:"+Frame.state
	
  when "lparOn"	

	startFrameAndCheckProgress(frame)
	 
	 
	lpars = lparName.split(",")

	lpars.each do |lpar|
	   puts "lpar to check #{lpar}"  

		lparID=Exec.Exec(Frame.findLparID(lpar), "on")
		
		STDERR.puts "Checking the lparID of #{lpar}"
		if (lparID.match("HSCL8012"))
			puts "The lpar #{lpar} doesn't exist on Frame #{frame}, exiting..."
			exit 3
		end
		lparID=lparID.gsub("\n","")
		STDERR.puts "lpar ID of lpar #{lpar} is #{lparID}"	

		lparReal = Lpar_real.new(frame, lparID, lpar)
		puts Exec.Exec(lparReal.start("normal"))		
	end 
	


  when "lparMemoryAdd"	
	 lpar = Lpar_real.new(frame, lparID, lparName)
	 puts Exec.Exec(lpar.memoryAdd(1024))	 

  when "lparMemoryRemove"	
	 lpar = Lpar_real.new(frame, lparID, lparName)
	 puts Exec.Exec(lpar.memoryRemove(1024))	 

  when "lparProcUnitsRemove"	
	 lpar = Lpar_real.new(frame, lparID, lparName)
	 puts Exec.Exec(lpar.procUnitsRemove(0.1))	 

 when "lparProcUnitsAdd"	
	 lpar = Lpar_real.new(frame, lparID, lparName)
	 puts Exec.Exec(lpar.procUnitsAdd(0.1))	 

	 
 when "lparAddVscsi"	 
	lpar = Lpar_real.new(frame, lparID, lparName)
	puts Exec.Exec(lpar.vscsiAdd(2, lparID, 2))	
	puts Exec.Exec(lpar.vscsiAdd(3, lparID, 3))	
	 
 when "lparOff"	
 
 	lpars = lparName.split(",")

	lpars.each do |lpar|

		lparID=Exec.Exec(Frame.findLparID(lpar), "on")
		
		STDERR.puts "Checking the lparID of #{lpar}"
		if (lparID.match("HSCL8012"))
			puts "The lpar #{lpar} doesn't exist on Frame #{frame}, exiting..."
			exit 3
		end
		lparID=lparID.gsub("\n","")
		STDERR.puts "lpar ID of lpar #{lpar} is #{lparID}"	
	
	
		lpar = Lpar_real.new(frame, lparID, lpar)
		puts Exec.Exec(lpar.stop())
	end

	when "lparRemove"
		lpar = Lpar_real.new(frame, lparID, lparName)
		#puts Exec.Exec(lpar.lparRemove())
	
	
  when "lparCreate"
	vent1 = VirtualEthAdapter.new()
	vent1.virtualSlotNmuber=2
	vent1.portVlanID=1

	vent2 = VirtualEthAdapter.new()
	vent2.virtualSlotNmuber=3
	vent2.portVlanID=2
	
	vscsi1 = VirtualScsiAdapter.new()
	vscsi1.virtualSlotNmuber=4
	vscsi1.clientOrServer="client"
	vscsi1.remoteLparID=2
	vscsi1.remoteLparName="vios1"
	vscsi1.remoteSlotNumber=11
	vscsi1.isRequired=1
	
	vscsi2 = VirtualScsiAdapter.new()
	vscsi2.virtualSlotNmuber=5
	vscsi2.clientOrServer="client"
	vscsi2.remoteLparID=3
	vscsi2.remoteLparName="vios2"
	vscsi2.remoteSlotNumber=12
	vscsi2.isRequired=1	
	
	lpar = Lpar_profile.new(frame, lparName, lparID)
	lpar.adapter_eth_add(vent1)
	lpar.adapter_eth_add(vent2)
	
	lpar.adapter_scsi_add(vscsi1)
	lpar.adapter_scsi_add(vscsi2)
	
	puts Exec.Exec(lpar.get_mksyscfg)
  
  when "checkVIOS"
  
	puts "Will check real (current) slot configuration for VIOS"
	puts " *Getting list of lpars on Frame (lparName and ID)"
		String1 = Exec.Exec(Frame.getLparsList(), "on")
		array = Hash.new()
		lpars = Hash.new()

		String1.split("\n").each { |line|
			(index, value) = line.split(",")
			array[index.to_i]=value
			lpars[index.to_i]= Lpar_real.new(frame, index, value)	
		}

	puts " -Getting VIOS virtual slot configuration"
	puts " --getting vscsi adapters"
	puts ""
	
	Adapters =  Exec.Exec(Frame.getLparsScsiSlots(), "on")
	
	slotsUsed = Hash.new{ |h,k| h[k] = Hash.new(&h.default_proc) }
	
	Adapters.split("\n").each { |line| 

		regExp = /lpar_name=([\w\-\_]+),lpar_id=(\d+),(.*)/
		match = regExp.match(line)
		abort "RegExp couldn't decode string #{line}" unless match	

			adapter = VirtualScsiAdapter.new()
			adapter.decode(match[3])
			
			slotsUsed[match[2].to_i][adapter.virtualSlotNmuber] = "notUsed"

			lpars[match[2].to_i].adapter_scsi_add(adapter)	
	}
	
	lpars.keys.each { |lparID|
			#lpar is VIOS, so let's check if remote lpar exist 
			lpars[lparID].virtual_scsi_adapters.keys.each { |adapterID|

				lparRemoteID = lpars[lparID].virtual_scsi_adapters[adapterID].remoteLparID
				slotRemoteID = lpars[lparID].virtual_scsi_adapters[adapterID].remoteSlotNumber
			
				slotLocal  = lpars[lparID].virtual_scsi_adapters[adapterID]
			
				next if ( slotLocal.clientOrServer == "server" )
	
				if (lpars.key?(lparRemoteID.to_i))
					if ( lpars[lparRemoteID.to_i].virtual_scsi_adapters.key?(slotRemoteID.to_i))
						slotsUsed[lparRemoteID.to_i][slotRemoteID.to_i] = "Used"
						slotsUsed[lparID.to_i][adapterID.to_i] = "Used"
					end
				end	
			}
	}

	puts "report of SCSI slots using "
	puts "Exec mode:" + execMode 
	
	slotsUsed.each  do | key, value| 
		#puts "lparID: " + key.to_s
		slotsUsed[key].each do | key2, value2 |
			#pp "lparID: " + key.to_s + " slot " + key2.to_s + " value " + slotsUsed[key][key2]
			next if slotsUsed[key][key2] == "Used"
			puts lpars[key].slotRemove(key2)
		end
	end
  
  #
  puts "checking profiles"
  profiles = Hash.new{ |h,k| h[k] = Hash.new(&h.default_proc) } 
  String2 = Exec.Exec(Frame.getProfiles(), "on")
  String2.split("\n").each do  |line| 
	#puts "Profile " + line 
	
	regExp = /name=([\w\-\_]+),lpar_name=([\w\-\_]+),lpar_id=(\d+),(.*)/
	match = regExp.match(line)
	abort "RegExp couldn't decode string #{line}" unless match		
		
	#puts "profile:" + match[1]
	#puts "lpar   :" + match[2]
	#puts "lparID :" + match[3]
	#puts "string :" + match[4]
	#puts ""
	
	# sys, lpar_name, lpar_id, name="normal"
	profile = Lpar_profile.new(frame, match[2], match[3], match[1])
	profile.lssyscfgProfDecode(line)
	profiles[match[2]][match[1]] = profile 
	
  end
  
  when "off"
	puts "Will power off the frame"
	puts Frame.stop()
	puts Exec.Exec(Frame.stop())  
  
  else
    print "Illegal command: #{action}\n\n"
end

