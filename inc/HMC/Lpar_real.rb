require 'pp'
require 'HMC/VirtualEthAdapter'
require 'HMC/HmcString'

include HmcString


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

	#power7
  attr_reader :time_ref
  attr_reader :lpar_avail_priority
  attr_reader :remote_restart_capable
  attr_reader :suspend_capable
  attr_reader :desired_lpar_proc_compat_mode
  attr_reader :curr_lpar_proc_compat_mode
  attr_reader :affinity_group_id

  #stolen from https://github.com/vfoucault/powervmtools
  #and from https://www.ibm.com/support/knowledgecenter/en/POWER8/p8edm/mksyscfg.html
  #vtpm_enabled - virtual Trusted Platform Module (enabled or disabled)
  #power8
  attr_reader :vtpm_enabled
  attr_reader :simplified_remote_restart_capable
  attr_reader :remote_restart_status

  #taken from doc for power8: https://www.ibm.com/support/knowledgecenter/en/POWER8/p8edm/mksyscfg.html
  attr_reader :msp #mover service partition
  attr_reader :powervm_mgmt_capable #Linux only: allow this partition to provide PowerVM management functions

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

  @lpar_name

	@lpar_env

  # string from command ''
  @lpar_id
  @allow_perf_collection
  @auto_start
  @shared_proc_pool_util_auth
  @redundant_err_path_reporting
  @sync_curr_profile

  @name
  @lpar_env
  @state
  @resource_config
  @os_version
  @logical_serial_num
  @default_profile
  @curr_profile
  @work_group_id
  @power_ctrl_lpar_ids
  @boot_mode
  @lpar_keylock
  @rmc_state
  @rmc_ipaddr


	def initialize sys,lpar_id,name 
	
		@name = name
		@sys = sys
		@lpar_id= lpar_id.to_i
		@dataString = ''

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

    @_variables = Hash.new
    @_variables['variables_int']    = %w(lpar_id allow_perf_collection auto_start shared_proc_pool_util_auth redundant_err_path_reporting sync_curr_profile
			time_ref lpar_avail_priority remote_restart_capable suspend_capable simplified_remote_restart_capable vtpm_enabled msp powervm_mgmt_capable)
    @_variables['variables_string'] = %w(name lpar_env state resource_config os_version logical_serial_num default_profile curr_profile
      work_group_id power_ctrl_lpar_ids boot_mode lpar_keylock  rmc_state rmc_ipaddr
			desired_lpar_proc_compat_mode curr_lpar_proc_compat_mode affinity_group_id remote_restart_status )

    @_variables['memory_int']    = %w(lpar_id curr_min_mem curr_mem curr_max_mem pend_min_mem pend_mem pend_max_mem run_min_mem run_mem curr_min_num_huge_pages
      curr_num_huge_pages curr_max_num_huge_pages pend_min_num_huge_pages pend_num_huge_pages pend_max_num_huge_pages run_num_huge_pages)
    @_variables['memory_string'] = %w(mem_mode)

    @_variables['proc_int']    = %w(lpar_id curr_shared_proc_pool_id curr_min_procs curr_procs curr_max_procs curr_uncap_weight pend_shared_proc_pool_id
      	pend_min_procs pend_procs pend_max_procs run_procs pend_uncap_weight run_uncap_weight)
    @_variables['proc_string'] = %w(curr_proc_mode curr_sharing_mode pend_proc_mode pend_sharing_mode)
    @_variables['proc_float']  = %w(curr_min_proc_units pend_min_proc_units pend_proc_units pend_max_proc_units run_proc_units curr_proc_units curr_max_proc_units)

	end

	def start_cmd profile
		"chsysstate -m #{@sys} -r lpar -n #{@name} -o on -f #{profile}"
	end
	
	def stop_cmd
		"chsysstate -m #{@sys} -r lpar -n #{@name} -o shutdown"
	end	

	def status_cmd
		"lssyscfg -m #{@sys} -r lpar -F state  --filter='#{@name}'"
	end 
	
	def memoryAdd_cmd howMuch
		"chhwres -m #{@sys} -p #{@name} -r mem -o a  -q #{howMuch.to_s}"
	end

	def memoryRemove_cmd howMuch
		"chhwres -m #{@sys} -p #{@name} -r mem -o r  -q #{howMuch.to_s}"
	end

	def procUnitsAdd_cmd howMuch
		"chhwres -m #{@sys} -p #{@name} -r proc -o a --procunits #{howMuch.to_s}"
	end	

	def procUnitsRemove_cmd howMuch
		"chhwres -m #{@sys} -p #{@name} -r proc -o r --procunits #{howMuch.to_s}"
	end	
	
	def memoryRestoreToProfile_cmd
		""
	end
	
	def slotRemove_cmd slotID
		"chhwres -r virtualio -m #{@sys} -o  r -p #{@name} -s #{slotID}"
	end
	
	def lparRemove_cmd
		"rmsyscfg -m #{@sys} -r lpar -n #{@name}"
	end
	
	def lssyscfgDecode string

    HmcString.parse(string).each {|name, value|

      if @_variables['variables_int'].include?(name)
        instance_variable_set("@#{name}", value.to_i)
      elsif @_variables['variables_string'].include?(name)
        instance_variable_set("@#{name}", value.to_s)
      else
        print "unknown name: #{name} with value #{value}"
        raise
      end

		}
	end
	
	def decodeMem string

    HmcString.parse(string).each {|name, value|

      if @_variables['memory_int'].include?(name)
        instance_variable_set("@#{name}", value.to_i)
      elsif @_variables['memory_string'].include?(name)
        instance_variable_set("@#{name}", value.to_s)
      elsif name == 'curr_hpt_ratio'
        @curr_hpt_ratio = value.to_s
      elsif name == 'lpar_name'
        @lpar_name = value
      else
        print "unknown name: #{name} with value #{value}"
        raise
      end
    }

	end
	
	def decodeProc string 

    HmcString.parse(string).each {|name, value|

      if @_variables['proc_int'].include?(name)
        instance_variable_set("@#{name}", value.to_i)
      elsif @_variables['proc_float'].include?(name)
        instance_variable_set("@#{name}", value.to_f)
      elsif @_variables['proc_string'].include?(name)
        instance_variable_set("@#{name}", value.to_s)
      elsif name == 'lpar_name'
        @lpar_name = value
      else
        print "unknown name: #{name} with value #{value}"
        raise
      end
    }

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

    string.split(/\n/).each { |line|

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

	def virtual_adapter_exist? adapterID
		@adaptersVirtual.key?(adapterID)
	end

	
	def adapter_scsi_add adapter
		
		@virtual_scsi_adapters[adapter.virtualSlotNmuber] = adapter 
		

		#@virtual_eth_adapters[adapter]
#		@virtual_scsi_adapters.push(adapter)
	end		
	
end	