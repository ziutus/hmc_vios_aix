class Sys

	#attr_accessor :sys, :dataString
	attr_reader :sys, :dataString
	
	#power5 
	attr_reader :name, :state, :type_model, :serial_num, :ipaddr, :state, :detailed_state, :sys_time, :power_off_policy 
	attr_reader :active_lpar_mobility_capable, :inactive_lpar_mobility_capable, :active_lpar_share_idle_procs_capable, :active_mem_expansion_capable, :hardware_active_mem_expansion_capable
	attr_reader :active_mem_sharing_capable, :addr_broadcast_perf_policy_capable, :bsr_capable, :cod_mem_capable, :cod_proc_capable, :dynamic_platform_optimization_capable, :electronic_err_reporting_capable
	attr_reader :firmware_power_saver_capable, :hardware_power_saver_capable, :hardware_discovery_capable, :hca_capable, :huge_page_mem_capable, :lhea_capable, :lpar_avail_priority_capable
	attr_reader :lpar_proc_compat_mode_capable, :lpar_remote_restart_capable, :powervm_lpar_remote_restart_capable, :lpar_suspend_capable, :micro_lpar_capable, :os400_capable, :redundant_err_path_reporting_capable
	attr_reader :shared_eth_failover_capable, :sni_msg_passing_capable, :sp_failover_capable, :vet_activation_capable, :virtual_fc_capable, :virtual_io_server_capable, :virtual_switch_capable
	attr_reader :vsn_phase2_capable, :vsi_on_veth_capable, :assign_5250_cpw_percent, :max_lpars, :max_power_ctrl_lpars, :max_remote_restart_capable_lpars, :max_suspend_capable_lpars, :hca_bandwidth_capabilities
	attr_reader :service_lpar_id, :service_lpar_name, :curr_sys_keylock, :pend_sys_keylock, :curr_power_on_side, :pend_power_on_side, :curr_power_on_speed, :pend_power_on_speed, :curr_power_on_speed_override
	attr_reader :pend_power_on_speed_override, :power_on_type, :power_on_option, :power_on_lpar_start_policy, :pend_power_on_option, :pend_power_on_lpar_start_policy, :power_on_method 
	attr_reader :power_on_attr, :sp_boot_attr, :sp_boot_major_type, :sp_boot_minor_type, :sp_version, :mfg_default_config, :curr_mfg_default_ipl_source, :pend_mfg_default_ipl_source
	attr_reader :curr_mfg_default_boot_mode, :pend_mfg_default_boot_mode
	attr_reader :application_capable_5250 #changed as number can't be on the beginning

	
	def initialize sys 
		@sys = sys
		
		#Power5 data
		@name
		@type_model
		@serial_num
		@ipaddr
		@state=""
		@detailed_state
		@sys_time
		@power_off_policy
		@active_lpar_mobility_capable
		@inactive_lpar_mobility_capable
		@active_lpar_share_idle_procs_capable
		@active_mem_expansion_capable
		@hardware_active_mem_expansion_capable
		@active_mem_sharing_capable
		@addr_broadcast_perf_policy_capable
		@bsr_capable
		@cod_mem_capable
		@cod_proc_capable
		@dynamic_platform_optimization_capable
		@electronic_err_reporting_capable
		@firmware_power_saver_capable
		@hardware_power_saver_capable
		@hardware_discovery_capable
		@hca_capable
		@huge_page_mem_capable
		@lhea_capable
		@lpar_avail_priority_capable
		@lpar_proc_compat_mode_capable
		@lpar_remote_restart_capable
		@powervm_lpar_remote_restart_capable
		@lpar_suspend_capable
		@micro_lpar_capable
		@os400_capable
		@application_capable_5250 # checked name
		@redundant_err_path_reporting_capable
		@shared_eth_failover_capable
		@sni_msg_passing_capable
		@sp_failover_capable
		@vet_activation_capable
		@virtual_fc_capable
		@virtual_io_server_capable
		@virtual_switch_capable
		@vsn_phase2_capable
		@vsi_on_veth_capable
		@assign_5250_cpw_percent
		@max_lpars
		@max_power_ctrl_lpars
		@max_remote_restart_capable_lpars
		@max_suspend_capable_lpars
		@hca_bandwidth_capabilities
		@service_lpar_id
		@service_lpar_name
		@curr_sys_keylock
		@pend_sys_keylock
		@curr_power_on_side
		@pend_power_on_side
		@curr_power_on_speed
		@pend_power_on_speed
		@curr_power_on_speed_override
		@pend_power_on_speed_override
		@power_on_type
		@power_on_option
		@power_on_lpar_start_policy
		@pend_power_on_option
		@pend_power_on_lpar_start_policy
		@power_on_method
		@power_on_attr
		@sp_boot_attr
		@sp_boot_major_type
		@sp_boot_minor_type
		@sp_version
		@mfg_default_config
		@curr_mfg_default_ipl_source
		@pend_mfg_default_ipl_source
		@curr_mfg_default_boot_mode
		@pend_mfg_default_boot_mode
		
	end
	
	def dataSet dataString
		@dataString = dataString
	end
	
	def decodeString string
		
		parameters = string.split(",")
		
		parameters.each { |x| 
			key, value = x.split("=")
			
			case key 

				when "name"								then @name=value
				when "type_model" 						then	@type_model=value 
				when "serial_num" 						then	@serial_num=value
				when "ipaddr" 							then	@ipaddr=value
				when "state" 								then						@state=value
				when "detailed_state" 					then		@detailed_state=value
				when "sys_time" 							then		@sys_time=value
				when "power_off_policy" 					then		@power_off_policy=value
				when "active_lpar_mobility_capable" 		then		@active_lpar_mobility_capable=value
				when "inactive_lpar_mobility_capable" 	then		@inactive_lpar_mobility_capable=value
				when "active_lpar_share_idle_procs_capable" then		@active_lpar_share_idle_procs_capable=value
				when "active_mem_expansion_capable" 		then		@active_mem_expansion_capable=value
				when "hardware_active_mem_expansion_capable" then		@hardware_active_mem_expansion_capable=value
				when "active_mem_sharing_capable"			then		@active_mem_sharing_capable=value
				when "addr_broadcast_perf_policy_capable" then		@addr_broadcast_perf_policy_capable=value
				when "bsr_capable" 						then		@bsr_capable=value
				when "cod_mem_capable" 					then		@cod_mem_capable=value
				when "cod_proc_capable" 					then		@cod_proc_capable=value
				when "dynamic_platform_optimization_capable" then		@dynamic_platform_optimization_capable=value
				when "electronic_err_reporting_capable" then		@electronic_err_reporting_capable=value
				when "firmware_power_saver_capable" 	then		@firmware_power_saver_capable=value
				when "hardware_power_saver_capable" 	then		@hardware_power_saver_capable=value
				when "hardware_discovery_capable" 	then		@hardware_discovery_capable=value
				when "hca_capable" 					then		@hca_capable=value
				when "huge_page_mem_capable" 			then		@huge_page_mem_capable=value
				when "lhea_capable" 					then		@lhea_capable=value
				when "lpar_avail_priority_capable" 	then		@lpar_avail_priority_capable=value
				when "lpar_proc_compat_mode_capable" 	then		@lpar_proc_compat_mode_capable=value
				when "lpar_remote_restart_capable" 	then		@lpar_remote_restart_capable=value
				when "powervm_lpar_remote_restart_capable" then		@powervm_lpar_remote_restart_capable=value
				when "lpar_suspend_capable" 			then		@lpar_suspend_capable=value
				when "micro_lpar_capable" 			then		@micro_lpar_capable=value
				when "os400_capable" 					then		@os400_capable=value
				when "redundant_err_path_reporting_capable" then		@redundant_err_path_reporting_capable=value
				when "shared_eth_failover_capable" 	then		@shared_eth_failover_capable=value
				when "sni_msg_passing_capable" 		then		@sni_msg_passing_capable=value
				when "sp_failover_capable" 			then		@sp_failover_capable=value
				when "vet_activation_capable" 		then		@vet_activation_capable=value
				when "virtual_fc_capable" 			then		@virtual_fc_capable=value
				when "virtual_io_server_capable" 		then		@virtual_io_server_capable=value
				when "virtual_switch_capable" 		then		@virtual_switch_capable=value
				when "vsn_phase2_capable" 			then		@vsn_phase2_capable=value
				when "vsi_on_veth_capable" 			then		@vsi_on_veth_capable=value
				when "assign_5250_cpw_percent" 		then		@assign_5250_cpw_percent=value
				when "max_lpars" 						then		@max_lpars=value
				when "max_power_ctrl_lpars" 			then		@max_power_ctrl_lpars=value
				when "max_remote_restart_capable_lpars" then		@max_remote_restart_capable_lpars=value
				when "max_suspend_capable_lpars" 		then		@max_suspend_capable_lpars=value
				when "hca_bandwidth_capabilities" 	then		@hca_bandwidth_capabilities=value
				when "service_lpar_id" 				then		@service_lpar_id=value
				when "service_lpar_name" 				then		@service_lpar_name=value
				when "curr_sys_keylock"				then		@curr_sys_keylock=value
				when "pend_sys_keylock" 				then		@pend_sys_keylock=value
				when "curr_power_on_side" 			then		@curr_power_on_side=value
				when "pend_power_on_side" 			then		@pend_power_on_side=value
				when "curr_power_on_speed" 			then		@curr_power_on_speed=value
				when "pend_power_on_speed" 			then		@pend_power_on_speed=value
				when "curr_power_on_speed_override" 	then		@curr_power_on_speed_override=value
				when "pend_power_on_speed_override" 	then		@pend_power_on_speed_override=value
				when "power_on_type" 					then		@power_on_type=value
				when "power_on_option" 				then		@power_on_option=value
				when "power_on_lpar_start_policy" 	then		@power_on_lpar_start_policy=value
				when "pend_power_on_option" 			then		@pend_power_on_option=value
				when "pend_power_on_lpar_start_policy" then		@pend_power_on_lpar_start_policy=value
				when "power_on_method" 				then		@power_on_method=value
				when "power_on_attr" 					then		@power_on_attr=value
				when "sp_boot_attr" 					then		@sp_boot_attr=value
				when "sp_boot_major_type" 			then		@sp_boot_major_type=value
				when "sp_boot_minor_type" 			then		@sp_boot_minor_type=value
				when "sp_version" 					then		@sp_version=value
				when "mfg_default_config" 			then		@mfg_default_config=value
				when "curr_mfg_default_ipl_source" 	then		@curr_mfg_default_ipl_source=value
				when "pend_mfg_default_ipl_source" 	then		@pend_mfg_default_ipl_source=value
				when "curr_mfg_default_boot_mode" 	then		@curr_mfg_default_boot_mode=value
				when "pend_mfg_default_boot_mode" 	then		@pend_mfg_default_boot_mode=value
				when "5250_application_capable" 	then 		@application_capable_5250=value
				else
					abort __FILE__ + "unknown parametr "+key+"\n"
			end		
		}
		
	end
	
	def statusCheck
		"lssyscfg -m #{@sys} -r sys -F state"
	end
	
	def dataGet
		"lssyscfg -r sys"
	end
	
	def start
		"chsysstate -m #{@sys} -r sys -o on"
	end
	
	# each type of frame can have different time to start 
	# this function is used in sleep value to not check to often the state of frame 
	def startTime
		return 120 
	end
	
	def stop
		"chsysstate -m #{@sys} -r sys -o off"
	end
	
	def findLparID lparName
		"lssyscfg -r lpar -m #{@sys} --filter \"lpar_names=#{lparName}\" -F lpar_id"
	end	
	
	def findLparName lparID
		"lssyscfg -r lpar -m #{@sys} --filter \"lpar_ids=#{lparID}\" -F name"
	end

	def findLparName lparID
		"lssyscfg -r lpar -m #{@sys} --filter \"lpar_ids=#{lparID}\" -F name"
	end

	def getLparsList
	    "lssyscfg -r lpar -m #{@sys} -F \"lpar_id,name\""
	end 
	
	def getLparsScsiSlots
		"lshwres -r virtualio --rsubtype scsi -m #{@sys} --level lpar"
	end
	
	
	def getProfiles
		"lssyscfg -r prof -m #{@sys}"
	end 
	
	# https://www.ibm.com/support/knowledgecenter/P8ESS/p8edm/lslic.html
	# lslic - list Licensed Internal Code levels
	def lslic
		"lslic -m #{@sys} -t syspower"
	end
end	