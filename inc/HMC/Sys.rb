require 'HMC/HmcString'
require 'HMC/HmcLpar'

include HmcString


class Sys

	#attr_accessor :sys, :dataString
	attr_reader :sys
  attr_reader :dataString
	
	#power5 
	attr_reader :name
  attr_reader :state
  attr_reader :type_model
  attr_reader :serial_num
  attr_reader :ipaddr
  attr_reader :state
  attr_reader :detailed_state
  attr_reader :sys_time
  attr_reader :power_off_policy
	attr_reader :active_lpar_mobility_capable
  attr_reader :inactive_lpar_mobility_capable
  attr_reader :active_lpar_share_idle_procs_capable
  attr_reader :active_mem_expansion_capable
  attr_reader :hardware_active_mem_expansion_capable
	attr_reader :active_mem_sharing_capable
  attr_reader :addr_broadcast_perf_policy_capable
  attr_reader :bsr_capable
  attr_reader :cod_mem_capable
  attr_reader :cod_proc_capable
  attr_reader :dynamic_platform_optimization_capable
  attr_reader :electronic_err_reporting_capable
	attr_reader :firmware_power_saver_capable
  attr_reader :hardware_power_saver_capable
  attr_reader :hardware_discovery_capable
  attr_reader :hca_capable
  attr_reader :huge_page_mem_capable
  attr_reader :lhea_capable
  attr_reader :lpar_avail_priority_capable
	attr_reader :lpar_proc_compat_mode_capable
  attr_reader :lpar_remote_restart_capable
  attr_reader :powervm_lpar_remote_restart_capable
  attr_reader :lpar_suspend_capable
  attr_reader :micro_lpar_capable
  attr_reader :os400_capable
  attr_reader :redundant_err_path_reporting_capable
	attr_reader :shared_eth_failover_capable
  attr_reader :sni_msg_passing_capable
  attr_reader :sp_failover_capable
  attr_reader :vet_activation_capable
  attr_reader :virtual_fc_capable
  attr_reader :virtual_io_server_capable
  attr_reader :virtual_switch_capable
	attr_reader :vsn_phase2_capable
  attr_reader :vsi_on_veth_capable
  attr_reader :assign_5250_cpw_percent
  attr_reader :max_lpars
  attr_reader :max_power_ctrl_lpars
  attr_reader :max_remote_restart_capable_lpars
  attr_reader :max_suspend_capable_lpars
  attr_reader :hca_bandwidth_capabilities
	attr_reader :service_lpar_id
  attr_reader :service_lpar_name
  attr_reader :curr_sys_keylock
  attr_reader :pend_sys_keylock
  attr_reader :curr_power_on_side
  attr_reader :pend_power_on_side
  attr_reader :curr_power_on_speed
  attr_reader :pend_power_on_speed
  attr_reader :curr_power_on_speed_override
	attr_reader :pend_power_on_speed_override
  attr_reader :power_on_type
  attr_reader :power_on_option
  attr_reader :power_on_lpar_start_policy
  attr_reader :pend_power_on_option
  attr_reader :pend_power_on_lpar_start_policy
  attr_reader :power_on_method
	attr_reader :power_on_attr
  attr_reader :sp_boot_attr
  attr_reader :sp_boot_major_type
  attr_reader :sp_boot_minor_type
  attr_reader :sp_version
  attr_reader :mfg_default_config
  attr_reader :curr_mfg_default_ipl_source
  attr_reader :pend_mfg_default_ipl_source
	attr_reader :curr_mfg_default_boot_mode
  attr_reader :pend_mfg_default_boot_mode
	attr_reader :application_capable_5250 #changed as number can't be on the beginning

  attr_reader :_variables

  attr_reader :lpars

	def initialize name = ''

		@name = name

    @_variables = Hash.new
    @_variables['int'] = %w(
      addr_broadcast_perf_policy_capable
      firmware_power_saver_capable
      hardware_power_saver_capable
      hca_capable
      huge_page_mem_capable
      sp_failover_capable

      sni_msg_passing_capable
      max_power_ctrl_lpars
    )

    @_variables['int_unavialble'] = %w( power_off_policy
      active_lpar_mobility_capable
      inactive_lpar_mobility_capable
      active_lpar_share_idle_procs_capable
      active_mem_expansion_capable
      hardware_active_mem_expansion_capable
      active_mem_sharing_capable
      bsr_capable
      cod_mem_capable
      cod_proc_capable
      dynamic_platform_optimization_capable
      electronic_err_reporting_capable
      hardware_discovery_capable
      lhea_capable
      lpar_avail_priority_capable
      lpar_proc_compat_mode_capable
      lpar_remote_restart_capable
      powervm_lpar_remote_restart_capable
      lpar_suspend_capable
      micro_lpar_capable
      os400_capable
      redundant_err_path_reporting_capable
      shared_eth_failover_capable
      vet_activation_capable
      virtual_fc_capable
      virtual_io_server_capable
      virtual_switch_capable
      vsn_phase2_capable
      vsi_on_veth_capable
      assign_5250_cpw_percent
      max_lpars
      max_remote_restart_capable_lpars
      max_suspend_capable_lpars
      hca_bandwidth_capabilities
      mfg_default_config
    )

    @_variables['string'] = %w(
      name type_model
      serial_num ipaddr
      state detailed_state
      sys_time
      service_lpar_id
      service_lpar_name
      curr_sys_keylock
      pend_sys_keylock
      curr_power_on_side
      pend_power_on_side
      curr_power_on_speed
      pend_power_on_speed
      curr_power_on_speed_override
      pend_power_on_speed_override
      power_on_type
      power_on_option
      power_on_lpar_start_policy
      pend_power_on_option
      pend_power_on_lpar_start_policy
      power_on_method
      power_on_attr
      sp_boot_attr
      sp_boot_major_type
      sp_boot_minor_type sp_version
      curr_mfg_default_ipl_source
      pend_mfg_default_ipl_source
      curr_mfg_default_boot_mode
      pend_mfg_default_boot_mode
    )

    @lpars = Array.new

  end
	
	def dataSet dataString
		@dataString = dataString
  end

  def parse_f string, format

    values = string.split(',')
    keys = format.split(',')

    keys.each_index {|id|

        key = keys[id]
        value = values[id]


        if @_variables['int_unavialble'].include?(key)
          if value == 'unavailable'  or value == 'null'
            instance_variable_set("@#{key}", value.to_s)
          else
            instance_variable_set("@#{key}", value.to_i)
          end
        elsif @_variables['string'].include?(key)
            instance_variable_set("@#{key}", value.to_s)
        elsif @_variables['int'].include?(key)
              instance_variable_set("@#{key}", value.to_i)
        elsif  key == '5250_application_capable'
          @application_capable_5250=value.to_i
        else
            print "unknown name: #{key} with value #{value}"
            raise
        end
    }

  end


	def decodeString string



		HmcString.parse(string).each {|name, value|

#      puts "#{name}: #{value}"

      if @_variables['int_unavialble'].include?(name)
        if value == 'unavailable' or value == 'null'
          instance_variable_set("@#{name}", value.to_s)
        else
          instance_variable_set("@#{name}", value.to_i)
        end
			elsif @_variables['int'].include?(name)
				instance_variable_set("@#{name}", value.to_i)
			elsif @_variables['string'].include?(name)
				instance_variable_set("@#{name}", value.to_s)
      elsif  name == '5250_application_capable'
        @application_capable_5250=value.to_i
			else
				print "unknown name: #{name} with value #{value}"
				raise
			end
		}
		
	end

  alias_method :parse, :decodeString

  def type_model_serial
    raise 'unknown type_model' if self.type_model.nil?
    raise 'unknown serial' if self.serial_num.nil?

    self.type_model.to_s + '*' + self.serial_num
  end

	def statusCheck_cmd
		"lssyscfg -m #{@name} -r sys -F state"
	end
	
	def dataGet_cmd
		"lssyscfg -r sys"
	end
	
	def start_cmd
		"chsysstate -m #{@name} -r sys -o on"
	end
	
	# each type of frame can have different time to start 
	# this function is used in sleep value to not check to often the state of frame 
	def startTime
		return 120 
	end


	def stop_cmd
		"chsysstate -m #{@name} -r sys -o off"
	end
	
	def findLparID_cmd lparName
		"lssyscfg -r lpar -m #{@name} --filter \"lpar_names=#{lparName}\" -F lpar_id"
	end	
	
	def findLparName_cmd lparID
		"lssyscfg -r lpar -m #{@name} --filter \"lpar_ids=#{lparID}\" -F name"
	end

	def getLparsList_cmd
	    "lssyscfg -r lpar -m #{@name} -F \"lpar_id,name\""
	end 
	
	def getLparsScsiSlots_cmd
		"lshwres -r virtualio --rsubtype scsi -m #{@name} --level lpar"
	end
	
	
	def getProfiles_cmd
		"lssyscfg -r prof -m #{@name}"
	end 
	
	# https://www.ibm.com/support/knowledgecenter/P8ESS/p8edm/lslic.html
	# lslic - list Licensed Internal Code levels
	def lslic_cmd
		"lslic -m #{@name} -t syspower"
  end

  def lpar_add_by_profile(profile_or_string)
#      lpar.sys = @name
#      @lpars.push(lpar)
  end

end	