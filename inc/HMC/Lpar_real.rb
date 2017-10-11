class Lpar_real

	attr_reader :sys
  attr_reader :dataString
  attr_reader	:name
	attr_reader :name
  attr_reader :lpar_id
  attr_reader :lpar_env
	attr_reader :state
  attr_reader :resource_config
  attr_reader :os_version
  attr_reader :logical_serial_num
  attr_reader :default_profile
  attr_reader :curr_profile
  attr_reader :work_group_id
  attr_reader :shared_proc_pool_util_auth
  attr_reader :allow_perf_collection
	attr_reader :power_ctrl_lpar_ids
  attr_reader :boot_mode
  attr_reader :lpar_keylock
  attr_reader :auto_start
  attr_reader :redundant_err_path_reporting
  attr_reader :rmc_state
  attr_reader :rmc_ipaddr
  attr_reader :sync_curr_profile

	#from memory string (lshwres -r mem --level lpar -m $MS) 				
	attr_reader	:curr_min_mem
  attr_reader :curr_mem
  attr_reader :curr_max_mem
  attr_reader :pend_min_mem
  attr_reader :pend_mem
  attr_reader :pend_max_mem
  attr_reader :run_min_mem
  attr_reader :run_mem
  attr_reader :curr_min_num_huge_pages
  attr_reader :curr_num_huge_pages
	attr_reader	:curr_max_num_huge_pages
  attr_reader :pend_min_num_huge_pages
  attr_reader :pend_num_huge_pages
  attr_reader :pend_max_num_huge_pages
  attr_reader :run_num_huge_pages
  attr_reader :mem_mode
  attr_reader :curr_hpt_ratio
	
	#
	attr_reader :curr_proc_mode
  attr_reader :curr_min_procs
  attr_reader :curr_procs
  attr_reader :curr_max_procs
  attr_reader :curr_sharing_mode
	attr_reader	:pend_proc_mode
  attr_reader :pend_min_procs
  attr_reader :pend_procs
  attr_reader :pend_max_procs
  attr_reader :pend_sharing_mode
	attr_reader :run_procs
	
	#
	attr_reader :curr_min_proc_units
  attr_reader :curr_proc_units
  attr_reader :curr_max_proc_units
  attr_reader :curr_uncap_weight
  attr_reader :curr_shared_proc_pool_id
	attr_reader :pend_min_proc_units
  attr_reader :pend_proc_units
  attr_reader :pend_max_proc_units
  attr_reader :pend_uncap_weight
  attr_reader :pend_shared_proc_pool_id
	attr_reader :run_proc_units
  attr_reader :run_procs
  attr_reader :run_uncap_weight
	
	#from slots: lshwres -r virtualio --level lpar --rsubtype slot -m $MS
	attr_reader	:curr_max_virtual_slots
  attr_reader :pend_max_virtual_slots
  attr_reader :next_avail_virtual_slot
	
	attr_reader :adaptersVirtual
  attr_reader :adaptersReal
	
	attr_reader :virtual_scsi_adapters
	
	# https://www.ibm.com/support/knowledgecenter/HW4P4/p8edm/rsthwres.html
	
	def initialize sys,lpar_id,name 
	
		@name = name
		@sys = sys
		@lpar_id= lpar_id.to_i
		@dataString = ''
		

		@lpar_env=''
		@state=''
		@resource_config=''
		@os_version=''
		@logical_serial_num=''
		@default_profile=''
		@curr_profile=''
		@work_group_id=''
		@shared_proc_pool_util_auth=''
		@allow_perf_collection=''
		@power_ctrl_lpar_ids=''
		@boot_mode=''
		@lpar_keylock=''
		@auto_start=''
		@redundant_err_path_reporting=''
		@rmc_state=''
		@rmc_ipaddr=''
		@sync_curr_profile=''
		
		
		#from memory string 
		@curr_min_mem=0		
		@curr_min_mem=0
		@curr_mem=0
		@curr_max_mem=0
		@pend_min_mem=0
		@pend_mem=0
		@pend_max_mem=0
		@run_min_mem=0
		@run_mem=0
		@curr_min_num_huge_pages=0
		@curr_num_huge_pages=0
		@curr_max_num_huge_pages=0
		@pend_min_num_huge_pages=0
		@pend_num_huge_pages=0
		@pend_max_num_huge_pages=0
		@run_num_huge_pages=0
		@mem_mode=""
		@curr_hpt_ratio=""		
		
		@adaptersVirtual = Hash.new()
#		@adaptersVirtual = []
		@adaptersReal = []
		
		@virtual_eth_adapters = []
		@virtual_scsi_adapters = []

		@virtual_serial_adapters = []
		
	end

	def start profile
		"chsysstate -m #{@sys} -r lpar -n #{@name} -o on -f #{profile}"
	end
	
	def stop
		"chsysstate -m #{@sys} -r lpar -n #{@name} -o shutdown"
	end	

	def status_cmd
		"lssyscfg -m #{@sys} -r lpar -F state  --filter='#{@name}'"
	end 
	
	def memoryAdd howMuch
		"chhwres -m #{@sys} -p #{@name} -r mem -o a  -q #{howMuch.to_s}"
	end

	def memoryRemove howMuch
		"chhwres -m #{@sys} -p #{@name} -r mem -o r  -q #{howMuch.to_s}"
	end

	def procUnitsAdd howMuch
		"chhwres -m #{@sys} -p #{@name} -r proc -o a --procunits #{howMuch.to_s}"
	end	

	def procUnitsRemove howMuch
		"chhwres -m #{@sys} -p #{@name} -r proc -o r --procunits #{howMuch.to_s}"
	end	
	
	def memoryRestoreToProfile
		""
	end
	
	def slotRemove slotID
		"chhwres -r virtualio -m #{@sys} -o  r -p #{@name} -s #{slotID}"
	end
	
	def lparRemove
		"rmsyscfg -m #{@sys} -r lpar -n #{@name}"
	end
	
	def lssyscfgDecode string
		
		parameters = string.split(",")
		
		parameters.each { |x| 
			key, value = x.split("=")
		
			value = "" if value==nil
	
			case key 

				when "name" 				then				@name=value
				when "lpar_id" 				then				@lpar_id=value
				when "lpar_env" 			then				@lpar_env=value
				when "state" 				then				@state=value
				when "resource_config" 		then				@resource_config=value
				when "os_version" 			then				@os_version=value
				when "logical_serial_num" 	then				@logical_serial_num=value
				when "default_profile" 		then				@default_profile=value
				when "curr_profile" 		then				@curr_profile=value
				when "work_group_id" 		then				@work_group_id=value
				when "shared_proc_pool_util_auth" then			@shared_proc_pool_util_auth=value
				when "allow_perf_collection" then				@allow_perf_collection=value
				when "power_ctrl_lpar_ids" 	then				@power_ctrl_lpar_ids=value
				when "boot_mode" 			then				@boot_mode=value
				when "lpar_keylock" 		then				@lpar_keylock=value
				when "auto_start" 			then				@auto_start=value
				when "redundant_err_path_reporting" then		@redundant_err_path_reporting=value
				when "rmc_state" 			then				@rmc_state=value
				when "rmc_ipaddr" 			then				@rmc_ipaddr=value
				when "sync_curr_profile" 	then				@sync_curr_profile=value			
				else
					abort "Unknown key #{key} with value #{value}, exiting... \n"
			end
		}			
	end
	
	def decode string 
	
		regExpMem = /lpar_name=([\w\_\-]),lpar_id=(\d+),curr_min_mem=(\d+),curr_mem=(\d+),curr_max_mem=(\d+),pend_min_mem=(\d+),pend_mem=(\d+),pend_max_mem=(\d+),run_min_mem=(\d+),run_mem=(\d+),curr_min_num_huge_pages=(\d+),curr_num_huge_pages=(\d+),curr_max_num_huge_pages=(\d+),pend_min_num_huge_pages=(\d+),pend_num_huge_pages=(\d+),pend_max_num_huge_pages=(\d+),run_num_huge_pages=(\d+),mem_mode=(ded),curr_hpt_ratio=(\d+\:\d+)/
	
	end
	
	def decodeMem string 

		regExpMem = /lpar_name=([\w\_\-]+),lpar_id=(\d+),curr_min_mem=(\d+),curr_mem=(\d+),curr_max_mem=(\d+),pend_min_mem=(\d+),pend_mem=(\d+),pend_max_mem=(\d+),run_min_mem=(\d+),run_mem=(\d+),curr_min_num_huge_pages=(\d+),curr_num_huge_pages=(\d+),curr_max_num_huge_pages=(\d+),pend_min_num_huge_pages=(\d+),pend_num_huge_pages=(\d+),pend_max_num_huge_pages=(\d+),run_num_huge_pages=(\d+),mem_mode=(ded),curr_hpt_ratio=(\d+\:\d+)/
		match = regExpMem.match(string)
		
		unless match 
			puts string 
			puts regExpMem
			puts match 
			puts "RegExp couldn't decode string #{string}"
			raise 
		end
		
		@curr_min_mem		= match[3].to_i		
		@curr_mem			= match[4].to_i
		@curr_max_mem		= match[5].to_i
		@pend_min_mem		= match[6].to_i
		@pend_mem			= match[7].to_i
		@pend_max_mem		= match[8].to_i
		@run_min_mem		= match[9].to_i
		@run_mem			= match[10].to_i
		@curr_min_num_huge_pages	= match[11].to_i
		@curr_num_huge_pages = match[12].to_i
		@curr_max_num_huge_pages = match[13].to_i
		@pend_min_num_huge_pages = match[14].to_i
		@pend_num_huge_pages     = match[15].to_i
		@pend_max_num_huge_pages = match[16].to_i
		@run_num_huge_pages		 = match[17].to_i
		@mem_mode				= match[18]
		@curr_hpt_ratio			= match[19]
		
	end
	
	def decodeProc string 

		regExpProcDedicated = /lpar_name=([\w\_\-]+),lpar_id=(\d+),curr_proc_mode=(ded),curr_min_procs=(\d+),curr_procs=(\d+),curr_max_procs=(\d+),curr_sharing_mode=(share_idle_procs|uncap),pend_proc_mode=(ded),pend_min_procs=(\d+),pend_procs=(\d+),pend_max_procs=(\d+),pend_sharing_mode=(share_idle_procs),run_procs=(\d+)/
		regExpProcShared    = /lpar_name=([\w\_\-]+),lpar_id=(\d+),curr_shared_proc_pool_id=(\d+),curr_proc_mode=(shared),curr_min_proc_units=(\d+\.\d+),curr_proc_units=(\d+\.\d+),curr_max_proc_units=(\d+\.\d+),curr_min_procs=(\d+),curr_procs=(\d+),curr_max_procs=(\d+),curr_sharing_mode=(share_idle_procs|uncap),curr_uncap_weight=(\d+),pend_shared_proc_pool_id=(\d+),pend_proc_mode=(shared),pend_min_proc_units=(\d+\.\d+),pend_proc_units=(\d+\.\d+),pend_max_proc_units=(\d+\.\d+),pend_min_procs=(\d+),pend_procs=(\d+),pend_max_procs=(\d+),pend_sharing_mode=(uncap),pend_uncap_weight=(\d+),run_proc_units=(\d+\.\d+),run_procs=(\d+),run_uncap_weight=(\d+)/
		
	
		match  = regExpProcDedicated.match(string)
		match2 = regExpProcShared.match(string)
		
		

		if match
		
			# dedicated CPU
			@curr_proc_mode			= match[3]
			@curr_min_procs			= match[4].to_i
			@curr_procs				= match[5].to_i
			@curr_max_procs			= match[6].to_i
			@curr_sharing_mode		= match[7]
			@pend_proc_mode			= match[8]
			@pend_min_procs			= match[9].to_i
			@pend_procs				= match[10].to_i
			@pend_max_procs			= match[11].to_i
			@pend_sharing_mode		= match[12]
			@run_procs				= match[13].to_i

		elsif match2 		
			#shared CPU	

			# #		lpar_name					= match[1]
			# #		lpar_id						= match[2].to_i
				
			@curr_shared_proc_pool_id	= match2[3].to_i
			@curr_proc_mode				= match2[4]
			@curr_min_proc_units			= match2[5]
			@curr_proc_units				= match2[6]
			@curr_max_proc_units			= match2[7]
			@curr_min_procs				= match2[8].to_i
			@curr_procs					= match2[9].to_i
			@curr_max_procs				= match2[10].to_i
			@curr_sharing_mode			= match2[11]
			@curr_uncap_weight			= match2[12].to_i
			@pend_shared_proc_pool_id	= match2[13].to_i
			@pend_proc_mode				= match2[14]
			@pend_min_proc_units			= match2[15]
			@pend_proc_units				= match2[16]
			@pend_max_proc_units			= match2[17]
			@pend_min_procs				= match2[18].to_i
			@pend_procs					= match2[19].to_i
			@pend_max_procs				= match2[20].to_i
			@pend_sharing_mode			= match2[21]
			@pend_uncap_weight			= match2[22].to_i
			@run_proc_units				= match2[23]
			@run_procs					= match2[24].to_i
			@run_uncap_weight			= match2[25].to_i	
			
			
		else
		
			puts string
			puts match 
			puts match2 
			puts "RegExp couldn't decode string #{string}"
			raise 
		end
		
	end
	
	def decodeVirtualioSlot string 
	
		regExpSlot = /lpar_name=([\w\_\-]+),lpar_id=(\d+),curr_max_virtual_slots=(\d+),pend_max_virtual_slots=(\d+),next_avail_virtual_slot=(\d+)/
		
		match = regExpSlot.match(string)
		
		unless match 
			puts string
			puts match 
			puts "RegExp couldn't decode string >#{string}<"
			raise 
		end
		
		@curr_max_virtual_slots	= match[3].to_i
		@pend_max_virtual_slots  = match[4].to_i
		@next_avail_virtual_slot = match[5].to_i
	end 

	def decodeVirtualioEth string 
	
		regExp1 = /lpar_name=([\w\_\-]+),lpar_id=(\d+),slot_num=(\d+),state=(0|1),is_required=(0|1),is_trunk=(0),ieee_virtual_eth=(\d+),port_vlan_id=(\d+),addl_vlan_ids=([\w\,]+|),mac_addr=(\w+|)/
		regExp2 = /lpar_name=([\w\_\-]+),lpar_id=(\d+),slot_num=(\d+),state=(0|1),is_required=(0|1),is_trunk=(1),trunk_priority=(\d+),ieee_virtual_eth=(0|1),port_vlan_id=(\d+),addl_vlan_ids=([\w\,]+|),mac_addr=(\w+|)/
		lines = string.split(/\n/)

		lines.each { |line|  

			match  = regExp1.match(line)
			match2 = regExp2.match(line)

			if match 
			
				next unless match[2].to_i == @lpar_id.to_i
				
				 adapter = VirtualEthAdapter.new
				
				 adapter.virtualSlotNumber = match[3].to_i
				 adapter.isIEEE			  = match[4].to_i
				 adapter.portVlanID 		  = match[5].to_i
				 adapter.additionalVlanIDs = match[6]
				 adapter.isTrunk           = match[7].to_i 
				 adapter.isRequired		  = match[8].to_i
				
				 adapter.macAddress		  = match[9]

				#@adaptersVirtual << adapter 
				adaptersVirtual[adapter.virtualSlotNumber] = adapter 
			
			elsif match2
			
				next unless match2[2].to_i == @lpar_id.to_i
				
				 adapter = VirtualEthAdapter.new()
				 
				 adapter.virtualSlotNumber = match2[3].to_i
				 adapter.isRequired		   = match2[5].to_i
				 adapter.isTrunk           = match2[6].to_i 				 
				 adapter.trunkPriority     = match2[7].to_i 
				 adapter.isIEEE			  = match2[8].to_i
				 adapter.portVlanID 		  = match2[9].to_i
				 adapter.additionalVlanIDs = match2[10]
				 adapter.macAddress		  = match2[11]

#				@adaptersVirtual << adapter 				 
				adaptersVirtual[adapter.virtualSlotNumber] = adapter 
			
			else 
				#puts string
				puts match 
				puts match2 
				puts "RegExp couldn't decode string >#{line}<"
				raise 		
			
			end
		}
	
	end 

	def adapter_eth_add adapter
		puts adapter.inspect
		exit 10
		#@virtual_eth_adapters[adapter]
	end
	
	def virtual_adapter_remove slotID
		adaptersVirtual.delete(slotID)
	end 
	
	def virtual_adapter_first_free 
		
		@max_virtual_slots=10 if @max_virtual_slots == nil 
		@max_virtual_slots=10 unless @max_virtual_slots > 0 
		for i in 0..@max_virtual_slots
#			puts "testing: #{i} \n"
			return i unless @adaptersVirtual.key?(i)
		end 
	end

	def virtual_adapter_exit? adapterID  
		
		@adaptersVirtual.key?(adapterID)
	end

	
	def adapter_scsi_add adapter
		
		@virtual_scsi_adapters[adapter.virtualSlotNmuber] = adapter 
		

		#@virtual_eth_adapters[adapter]
#		@virtual_scsi_adapters.push(adapter)
	end		
	
end	