require 'pp'
require 'HMC/HmcString'
require 'HMC/VirtualEthAdapter'
require 'HMC/VirtualScsiAdapter'
require 'HMC/VirtualSerialAdapter'
require 'HMC/VirtualFCAdapter'

include HmcString

class Lpar_profile

	attr_accessor :sys, :dataString, :name, :lpar_name
  attr_accessor :name, :lpar_id, :lpar_env
  attr_accessor :all_resources
  attr_accessor :min_mem, :desired_mem, :max_mem, :mem_mode, :hpt_ratio
  attr_accessor :min_num_huge_pages, :desired_num_huge_pages, :max_num_huge_pages

  attr_accessor :proc_mode, :min_proc_units, :desired_proc_units, :max_proc_units
  attr_accessor :min_procs, 	 :desired_procs, 	  :max_procs

  attr_accessor :sharing_mode, :uncap_weight
  attr_accessor :lpar_io_pool_ids, :lpar_io_pool_ids_raw
  attr_accessor :max_virtual_slots

  attr_accessor :auto_start, :conn_monitoring

  attr_accessor :resource_config, :os_version, :logical_serial_num, :default_profile, :curr_profile, :work_group_id, :shared_proc_pool_util_auth
  attr_accessor :allow_perf_collection
  attr_accessor :power_ctrl_lpar_ids, :boot_mode, :lpar_keylock, :redundant_err_path_reporting, :rmc_state, :rmc_ipaddr, :sync_curr_profile

  attr_accessor :mem_expansion, :affinity_group_id, :bsr_arrays, :lpar_proc_compat_mode
  attr_accessor :lhea_capabilities,  :lpar_proc_compat_mode, :electronic_err_reporting

  attr_reader :lhea_logical_ports,       :lhea_logical_ports_raw
  attr_reader :vtpm_adapters,            :vtpm_adapters_raw
  attr_reader :virtual_fc_adapters,      :virtual_fc_adapters_raw
  attr_reader :virtual_serial_adapters,  :virtual_serial_adapters_raw
  attr_reader :virtual_scsi_adapters,    :virtual_scsi_adapters_raw
  attr_reader :virtual_eth_adapters,     :virtual_eth_adapters_raw
  attr_reader :hca_adapters,             :hca_adapters_raw
  attr_reader :virtual_vasi_adapters,    :virtual_vasi_adapters_raw
  attr_reader :virtual_eth_vsi_profiles, :virtual_eth_vsi_profiles_raw
  attr_reader :io_slots,                 :io_slots_raw
  attr_reader :sriov_eth_logical_ports,  :sriov_eth_logical_ports_raw

  attr_accessor :sni_device_ids


  attr_accessor :_compatibility
  attr_reader   :_parametr_order
  attr_reader   :_default_params

	def initialize lpar_id='', name="normal"

    @lpar_id = lpar_id

		@variables_int    = [ 'lpar_id', 'min_mem', 'desired_mem', 'max_mem', 'all_resources', 'min_procs',
				'desired_procs', 'max_procs', 'max_virtual_slots', 'auto_start', 'conn_monitoring', 'uncap_weight',
				'bsr_arrays', 'shared_proc_pool_id' ]
				
		@variables_float  = [ 'min_proc_units', 'desired_proc_units', 'max_proc_units', 'mem_expansion' ]
	
		@variables_string_raw = [ 'virtual_serial_adapters', 'virtual_scsi_adapters', 'virtual_eth_adapters', 'io_slots', 'hca_adapters',
				'vtpm_adapters', 'virtual_fc_adapters', 'lhea_logical_ports', 'virtual_vasi_adapters',
				'virtual_eth_vsi_profiles', 'sriov_eth_logical_ports',
				'vnic_adapters' ]
				
		@variables_string = [ 'name', 'lpar_name', 'lpar_env', 'mem_mode', 'proc_mode', 'sharing_mode', 
			'lpar_io_pool_ids',  'boot_mode',
			'power_ctrl_lpar_ids', 'work_group_id', 'redundant_err_path_reporting', 'hpt_ratio',
			'affinity_group_id', 'lhea_capabilities' 'lpar_proc_compat_mode', 'lhea_capabilities', 'lpar_proc_compat_mode',
			'electronic_err_reporting', 'min_num_huge_pages', 'desired_num_huge_pages', 'max_num_huge_pages',
			'shared_proc_pool_name', 'sni_device_ids' ]

    @_default_params = Hash.new()

    @_default_params['power5'] = %w{name lpar_name lpar_id lpar_env all_resources min_mem desired_mem max_mem min_num_huge_pages
      desired_num_huge_pages max_num_huge_pages mem_mode hpt_ratio proc_mode min_proc_units
      desired_proc_units max_proc_units min_procs desired_procs max_procs sharing_mode uncap_weight
      io_slots lpar_io_pool_ids max_virtual_slots virtual_serial_adapters virtual_scsi_adapters virtual_eth_adapters
      hca_adapters boot_mode conn_monitoring auto_start power_ctrl_lpar_ids work_group_id redundant_err_path_reporting }

		@virtual_eth_adapters     = []
		@virtual_scsi_adapters    = []
		@virtual_serial_adapters  = []
		@virtual_fc_adapters      = []
    @lhea_logical_ports       = []
    @hca_adapters             = []
		@io_slots                 = []

    @_compatibility = 'power5'
    @_parametr_order = []

	end

  def io_slots_to_s

    unless @io_slots_raw.nil?
      if (@io_slots.size == 0)
        result =  'none'
      elsif (@io_slots.size == 1)
        result = @io_slots[0].join('/')
      else
        adapters=[]
        @io_slots.each { |adapter|
          adapters.push(adapter.join('/'))
        }
        result = adapters.join(',')
      end
    end

    result
  end


  def virtual_eth_adapters_to_s

    unless @virtual_eth_adapters_raw.nil?
      if (@virtual_eth_adapters.size == 0)
        result =  'none'
      else
        adapters=[]
        @virtual_eth_adapters.each { |adapter|
          adapters.push(adapter.to_s)
        }
        result = adapters.join(',')
      end
    end

    result
  end

  def virtual_fc_adapters_to_s

    unless @virtual_fc_adapters_raw.nil?
      result = 'virtual_fc_adapters='

      if (@virtual_fc_adapters.size == 0)
        result +=  'none'
      else
        adapters=[]
        @virtual_fc_adapters.each { |adapter|
          adapters.push(adapter.to_s)
        }
        result = adapters.join(',')
      end
    end

    result
  end

  def virtual_serial_adapters_to_s

    unless @virtual_serial_adapters_raw.nil?
      if    @virtual_serial_adapters.size == 0
        result = 'none'
      elsif @virtual_serial_adapters.size == 1
        result = @virtual_serial_adapters[0].to_s
      else
        adapters=[]
        @virtual_serial_adapters.each { |adapter|
          adapters.push(adapter.to_s)
        }
        result = adapters.join(',')
      end
    end
    result
  end

  def virtual_scsi_adapters_to_s

    unless @virtual_scsi_adapters_raw.nil?
        if @virtual_scsi_adapters.size == 0
          result =  'none'
        elsif @virtual_scsi_adapters.size == 1
          result =  @virtual_scsi_adapters[0].to_s
        else
          adapters=[]
          @virtual_scsi_adapters.each { |adapter|
            adapters.push(adapter.to_s)
          }
          result = adapters.join(',')
        end
    end
    result
  end


  def hca_adapters_to_s
    #TODO: it should have separate class of each adapter and function to analyze it (not used now on my Power5)
    unless @hca_adapters_raw.nil?
      'none'
    end
  end

  def vtpm_adapters_to_s
    #TODO: it should have separate class of each adapter and function to analyze it (not used now on my Power5)
    unless @vtpm_adapters_raw.nil?
      'none'
    end
  end

  def virtual_eth_vsi_profiles_to_s
    #TODO: it should have separate class of each adapter and function to analyze it (not used now on my Power5)
    unless @virtual_eth_vsi_profiles_raw.nil?
      'none'
    end
  end

  def lhea_logical_ports_to_s
    #TODO: it should have separate class of each adapter and function to analyze it (not used now on my Power5)
    unless @lhea_logical_ports_raw.nil?
      @lhea_logical_ports_raw
    end
  end

  def virtual_vasi_adapters_to_s
    #TODO: it should have separate class of each adapter and function to analyze it (not used now on my Power5)
    unless @virtual_vasi_adapters_raw.nil?
      'none'
    end
  end

  def sriov_eth_logical_ports_to_s
    #TODO: it should have separate class of each adapter and function to analyze it (not used now on my Power5)
    unless @sriov_eth_logical_ports_raw.nil?
      'none'
    end
  end

 # the result of command it the same as: lssyscfg -r prof -m $FRAME
  def to_s params='all'

      result_array    = []
      params_to_print = []

      if params == 'all'
          if @_parametr_order.count > 0
            params_to_print = @_parametr_order
          else
            params_to_print = @_default_params[ @_compatibility ]
          end
      else
          params_to_print = params.split(',')
      end

      params_with_functions = [ 'io_slots', 'virtual_serial_adapters', 'virtual_scsi_adapters', 'virtual_eth_adapters', 'hca_adapters',
                                'vtpm_adapters', 'virtual_fc_adapters', 'lhea_logical_ports', 'virtual_vasi_adapters',
                                'sriov_eth_logical_ports', 'virtual_eth_vsi_profiles']

      params_to_print.each { |parametr|

          if  params_with_functions.include?(parametr)
                tmp = self.adapters_to_s_F(parametr)
                unless tmp.nil?
                      tmp = parametr + '=' + tmp
                      if tmp.include?('"') or tmp.include?(',')
                        tmp = '"' + tmp + '"'
                      end
                      result_array.push(tmp)
                  end
          else
            unless self.instance_variable_get("@#{parametr}") == nil
              result_array.push (parametr + '=' + self.instance_variable_get("@#{parametr}").to_s)
            end
          end
      }

    result_array.join(',')
  end

  def adapters_to_s_F type

    if type == 'io_slots'
      tmp = self.io_slots_to_s
    elsif type == 'virtual_serial_adapters'
      tmp = self.virtual_serial_adapters_to_s
    elsif type == 'virtual_scsi_adapters'
      tmp = self.virtual_scsi_adapters_to_s
    elsif type == 'virtual_eth_adapters'
      tmp = self.virtual_eth_adapters_to_s
    elsif type == 'hca_adapters'
      tmp = self.hca_adapters_to_s
    elsif type == 'vtpm_adapters'
      tmp = self.vtpm_adapters_to_s
    elsif type == 'virtual_fc_adapters'
      tmp = self.virtual_fc_adapters_to_s
    elsif type == 'lhea_logical_ports'
      tmp = self.lhea_logical_ports_to_s
    elsif type == 'virtual_vasi_adapters'
      tmp = self.virtual_vasi_adapters_to_s
    elsif type == 'sriov_eth_logical_ports'
        tmp = self.sriov_eth_logical_ports_to_s
    elsif type == 'virtual_eth_vsi_profiles'
        tmp = self.virtual_eth_vsi_profiles_to_s
    else
      raise 'class:lpar_profile, function:adapters_to_s_F unknown type'
    end

    tmp
  end

  def get_mksyscfg
		"mksyscfg -r lpar -m #{@sys} -i \"" + self.to_s() + '"'

	end
	
	def adapter_eth_add adapter
		@virtual_eth_adapters.push(adapter)
	end
	
	def adapter_scsi_add adapter
		@virtual_scsi_adapters.push(adapter)
	end	
	
	def remove
		"rmsyscfg -m #{@sys} -r lpar -n #{@lpar_name}"
	end
	
	def lssyscfgDecode string
		
		parameters = string.split(',')
		
		parameters.each { |x| 
			key, value = x.split('=')
		
			value = '' if value==nil
	
			case key 

				when 'name' 									then				@name=value
				when 'lpar_id' 								then				@lpar_id=value
				when 'lpar_env' 							then				@lpar_env=value
				when 'state' 									then				@state=value
				when 'resource_config' 				then				@resource_config=value
				when 'os_version' 						then				@os_version=value
				when 'logical_serial_num' 		then				@logical_serial_num=value
				when 'default_profile' 				then				@default_profile=value
				when 'curr_profile' 					then				@curr_profile=value
				when 'work_group_id' 					then				@work_group_id=value
				when 'shared_proc_pool_util_auth' then		@shared_proc_pool_util_auth=value
				when 'allow_perf_collection' 	then				@allow_perf_collection=value
				when 'power_ctrl_lpar_ids' 		then				@power_ctrl_lpar_ids=value
				when 'boot_mode' 							then				@boot_mode=value
				when 'lpar_keylock' 					then				@lpar_keylock=value
				when 'auto_start' 						then				@auto_start=value
				when 'redundant_err_path_reporting' then	@redundant_err_path_reporting=value
				when 'rmc_state' 							then				@rmc_state=value
				when 'rmc_ipaddr' 						then				@rmc_ipaddr=value
				when 'sync_curr_profile' 			then				@sync_curr_profile=value
				else
					raise "Unknown key #{key} with value #{value}, exiting... \n"
			end
		}			
	end

	def lssyscfgProfDecode string 

		myHash = HmcString.parse(string)
		
		myHash.each { |name, value|

#      puts "#{name}: #{value}"

      if @variables_int.include?(name)
				instance_variable_set("@#{name}", value.to_i)
			elsif @variables_float.include?(name)
				instance_variable_set("@#{name}", value.to_f) 
			elsif @variables_string_raw.include?(name)
				instance_variable_set("@#{name}_raw", value.to_s) 
			elsif @variables_string.include?(name)
				instance_variable_set("@#{name}", value.to_s) 
			else 
				print "unknown name: #{name} with value #{value}"
				raise 
			end

      @_parametr_order.push(name)
		}	
	
		self._rawToTable()
	end
	
	def _rawToTable
		
		if @virtual_serial_adapters_raw != nil
			if @virtual_serial_adapters_raw != "none"
				@virtual_serial_adapters_raw.split(',').each { |adapter|
					@virtual_serial_adapters.push(VirtualSerialAdapter.new(adapter))
				}
			end
		end	

		if @virtual_eth_adapters_raw != nil		
			if @virtual_eth_adapters_raw != "none"
				HmcString.parse_value(@virtual_eth_adapters_raw).each { |adapter_string|
					@virtual_eth_adapters.push(VirtualEthAdapter.new(adapter_string))
				}	
			end
		end	

		if @virtual_scsi_adapters_raw != nil
			if @virtual_scsi_adapters_raw != "none"
				@virtual_scsi_adapters_raw.split(',').each { |adapter|
					@virtual_scsi_adapters.push(VirtualScsiAdapter.new(adapter))
				}
			end
		end	

		if @virtual_fc_adapters_raw != nil
			if @virtual_fc_adapters_raw != "none"
				HmcString.parse_value(@virtual_fc_adapters_raw).each { |adapter_string|
					@virtual_fc_adapters.push(VirtualFCAdapter.new(adapter_string))
				}	
			end	
		end

    if @io_slots_raw != nil
      if @io_slots_raw != "none"
        @io_slots_raw.split(',').each { |adapter_string|
          @io_slots.push(adapter_string.split('/'))
        }
      end
    end

    if @lhea_logical_ports_raw != nil
      if @lhea_logical_ports_raw != "none"
        @lhea_logical_ports_raw.split(',').each { |adapter_string|
          @lhea_logical_ports.push(adapter_string.split('/'))
        }
      end
    end

		#TODO: make decode code for @hca_adapters

	
	end
end