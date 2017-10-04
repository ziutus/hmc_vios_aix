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

  attr_reader :variables_string

	def initialize name = ''

		@name = name

    @variables_string = [ "name", 'type_model','serial_num','ipaddr', 'state',
      'detailed_state', 'sys_time', 'power_off_policy', 'active_lpar_mobility_capable', 'inactive_lpar_mobility_capable',
      'active_lpar_share_idle_procs_capable', 'active_mem_expansion_capable', 'active_mem_sharing_capable',
      'addr_broadcast_perf_policy_capable', 'hardware_active_mem_expansion_capable',
      'bsr_capable', 'cod_mem_capable', 'cod_proc_capable', 'dynamic_platform_optimization_capable', 'electronic_err_reporting_capable',
      'firmware_power_saver_capable', 'hardware_power_saver_capable', 'hardware_discovery_capable', 'hca_capable',
      'huge_page_mem_capable', 'lhea_capable',
      'active_lpar_mobility_capable', 'lpar_avail_priority_capable', 'lpar_proc_compat_mode_capable', 'lpar_remote_restart_capable',
      'powervm_lpar_remote_restart_capable',  'lpar_suspend_capable', 'micro_lpar_capable', 'os400_capable',
      'redundant_err_path_reporting_capable', 'shared_eth_failover_capable', 'sni_msg_passing_capable',
      'sp_failover_capable',  'vet_activation_capable',
      'virtual_fc_capable', 'virtual_io_server_capable', 'virtual_switch_capable', 'vsn_phase2_capable',
      'vsi_on_veth_capable', 'assign_5250_cpw_percent', 'max_lpars', 'max_power_ctrl_lpars',
      'max_remote_restart_capable_lpars', 'max_suspend_capable_lpars', 'hca_bandwidth_capabilities', 'service_lpar_id', 'service_lpar_name',
      'curr_sys_keylock',  'pend_sys_keylock', 'curr_power_on_side', 'pend_power_on_side', 'curr_power_on_speed',
      'pend_power_on_speed', 'curr_power_on_speed_override', 'pend_power_on_speed_override',
      'power_on_type', 'power_on_option', 'power_on_lpar_start_policy',
      'pend_power_on_option', 'pend_power_on_lpar_start_policy', 'power_on_method', 'power_on_attr',
      'sp_boot_attr', 'sp_boot_major_type', 'sp_boot_minor_type', 'sp_version',
      'mfg_default_config', 'curr_mfg_default_ipl_source', 'pend_mfg_default_ipl_source', 'curr_mfg_default_boot_mode', 'pend_mfg_default_boot_mode'
    ]


  end
	
	def dataSet dataString
		@dataString = dataString
	end

  def parse_f string, format

    keys = format.split(',')
    values = string.split(',')

    keys.each_index {|id|

        key = keys[id]
        value = values[id]

        if @variables_string.include?(key)
            instance_variable_set("@#{key}", value.to_s)
        elsif  key == '5250_application_capable'
          @application_capable_5250=value
        else
            print "unknown name: #{key} with value #{value}"
            raise
        end
    }

  end


	def decodeString string
		
    string.split(',').each { |x|
			key, value = x.split('=')

      if @variables_string.include?(key)
        instance_variable_set("@#{key}", value.to_s)
      elsif  key == '5250_application_capable'
        @application_capable_5250=value
      else
        print "unknown name: #{key} with value #{value}"
        raise
      end
		}
		
	end

  alias_method :parse, :decodeString

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