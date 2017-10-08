require 'pp'
require 'HMC/HmcString'
require 'HMC/VirtualEthAdapter'
require 'HMC/VirtualScsiAdapter'
require 'HMC/VirtualSerialAdapter'
require 'HMC/VirtualFCAdapter'

include HmcString

class Lpar_profile

	attr_reader :sys, :dataString, :name, :lpar_name
	attr_reader :name, :lpar_id, :lpar_env
	attr_reader :all_resources
	attr_reader :min_mem, :desired_mem, :max_mem, :mem_mode, :hpt_ratio
	attr_reader :min_num_huge_pages, :desired_num_huge_pages, :max_num_huge_pages
	
	attr_reader :proc_mode, :min_proc_units, :desired_proc_units, :max_proc_units
	attr_reader :min_procs, 	 :desired_procs, 	  :max_procs

	attr_reader :sharing_mode, :uncap_weight
	attr_reader :io_slots, :io_slots_raw
	attr_reader :lpar_io_pool_ids, :lpar_io_pool_ids_raw
	attr_reader :max_virtual_slots
	attr_reader :virtual_serial_adapters_raw, :virtual_serial_adapters
	attr_reader :virtual_scsi_adapters_raw, :virtual_scsi_adapters
	attr_reader :virtual_eth_adapters_raw, :virtual_eth_adapters
	attr_reader :hca_adapters_raw, :hca_adapters 

	attr_reader :auto_start, :conn_monitoring
	
	attr_reader :resource_config, :os_version, :logical_serial_num, :default_profile, :curr_profile, :work_group_id, :shared_proc_pool_util_auth, :allow_perf_collection 
	attr_reader :power_ctrl_lpar_ids, :boot_mode, :lpar_keylock, :redundant_err_path_reporting, :rmc_state, :rmc_ipaddr, :sync_curr_profile 

	attr_reader :mem_expansion, :affinity_group_id, :virtual_fc_adapters, :virtual_fc_adapters_raw, :bsr_arrays, :lpar_proc_compat_mode
	attr_reader :lhea_capabilities,  :lpar_proc_compat_mode, :electronic_err_reporting
	attr_reader :lhea_logical_ports, :lhea_logical_ports_raw
  attr_reader :vtpm_adapters, :vtpm_adapters_raw

  attr_reader :sni_device_ids

  attr_reader :virtual_vasi_adapters, :virtual_vasi_adapters_raw

  attr_reader :virtual_eth_vsi_profiles, :virtual_eth_vsi_profiles_raw

  attr_reader :_compatibility
  attr_reader :_parametr_order

	def initialize sys='', lpar_name='', lpar_id='', name="normal"

    @sys = sys
    @name = name
    @lpar_name = lpar_name
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

		@all_resources = ''
		@auto_start=0

		@boot_mode='norm'
		@conn_monitoring=1

		@lpar_env					='aixlinux'
		@lpar_io_pool_ids	='none'

		@min_mem     = 512
		@desired_mem = 2048
		@max_mem     = 4096

		@min_procs     = 1
		@desired_procs = 2
		@max_procs     = 3

		@min_proc_units     = 0.1
		@desired_proc_units = 0.2
		@max_proc_units     = 2.0

		@max_virtual_slots = 20

		@power_ctrl_lpar_ids=''
		@proc_mode='shared'

		@redundant_err_path_reporting=0
		
		@shared_proc_pool_util_auth='1'
		@sharing_mode='uncap'
		
		@uncap_weight=128
		@virtual_eth_adapters_raw	 		= 'none'
		@virtual_scsi_adapters_raw	 	= 'none'
		@virtual_serial_adapters_raw 	= 'none'
		@hca_adapters_raw 			 			= 'none'
    @io_slots_raw			=''

		@virtual_eth_adapters     = []
		@virtual_scsi_adapters    = []
		@virtual_serial_adapters  = []
		@virtual_fc_adapters      = []
    @lhea_logical_ports       = []
    @hca_adapters             = []
		@io_slots                 = []

		@work_group_id = ''

    @_compatibility = "power5"
    @_parametr_order = []

	end

  def io_slots_to_s

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
    result
  end


  def virtual_eth_adapters_to_s

    if (@virtual_eth_adapters.size == 0)
      result =  'none'
    else
      adapters=[]
      @virtual_eth_adapters.each { |adapter|
        adapters.push(adapter.to_s)
      }
      result = adapters.join(',')
    end

    result
  end

  def virtual_fc_adapters_to_s

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

    result
  end


  def virtual_serial_adapters_to_s

    if (@virtual_serial_adapters.size == 0)
      result =  'none'
    elsif (@virtual_serial_adapters.size == 1)
        result = @virtual_serial_adapters[0].to_s
    else
      adapters=[]
      @virtual_serial_adapters.each { |adapter|
        adapters.push(adapter.to_s)
      }
      result = adapters.join(',')
    end
    result
  end

  def virtual_scsi_adapters_to_s

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
    result
  end


  def hca_adapters_to_s
    #TODO: it should have separate class of each adapter and function to analyze it (not used now on my Power5)
    'none'
  end

  def vtpm_adapters_to_s
    #TODO: it should have separate class of each adapter and function to analyze it (not used now on my Power5)
    'none'
  end

  def virtual_eth_vsi_profiles
    #TODO: it should have separate class of each adapter and function to analyze it (not used now on my Power5)
    'none'
  end

  def lhea_logical_ports_to_s
    #TODO: it should have separate class of each adapter and function to analyze it (not used now on my Power5)
    @lhea_logical_ports_raw
  end

  def virtual_vasi_adapters_to_s
    #TODO: it should have separate class of each adapter and function to analyze it (not used now on my Power5)
    'none'
  end

  def sriov_eth_logical_ports_to_s
    #TODO: it should have separate class of each adapter and function to analyze it (not used now on my Power5)
    'none'
  end

  def virtual_eth_vsi_profiles_to_s
    #TODO: it should have separate class of each adapter and function to analyze it (not used now on my Power5)
    'none'
  end

 # the result of command it the same as: lssyscfg -r prof -m $FRAME
  def to_s


    if @_compatibility == "power5"
      result  = "name=#{@name},lpar_name=#{@lpar_name},lpar_id=#{@lpar_id},lpar_env=#{@lpar_env},all_resources=#{@all_resources},"
      result += "min_mem=#{@min_mem},desired_mem=#{@desired_mem},max_mem=#{@max_mem},"

      result += "min_num_huge_pages=#{@min_num_huge_pages},"          unless @min_num_huge_pages  == nil
      result += "desired_num_huge_pages=#{@desired_num_huge_pages},"  unless @desired_num_huge_pages  == nil
      result += "max_num_huge_pages=#{@max_num_huge_pages},"          unless @max_num_huge_pages  == nil

      result += "mem_mode=#{@mem_mode},"   unless @mem_mode  == nil
      result += "hpt_ratio=#{@hpt_ratio}," unless @hpt_ratio == nil
      result += "proc_mode=#{@proc_mode},min_proc_units=#{@min_proc_units},desired_proc_units=#{@desired_proc_units},max_proc_units=#{@max_proc_units},"
      result += "min_procs=#{@min_procs},desired_procs=#{@desired_procs},max_procs=#{@max_procs},sharing_mode=#{@sharing_mode},"
      result += "uncap_weight=#{@uncap_weight},"
      result += "shared_proc_pool_id=#{@shared_proc_pool_id},"     unless @shared_proc_pool_id == nil
      result += "shared_proc_pool_name=#{@shared_proc_pool_name}," unless @shared_proc_pool_name == nil
      result += "affinity_group_id=#{@affinity_group_id},"         unless @affinity_group_id == nil
      result += 'io_slots=' + self.io_slots_to_s() + ','
      result += "lpar_io_pool_ids=#{@lpar_io_pool_ids},"
      result += "max_virtual_slots=#{@max_virtual_slots},"
      result += 'virtual_serial_adapters=' + self.virtual_serial_adapters_to_s() + ','
      result += 'virtual_scsi_adapters=' + self.virtual_scsi_adapters_to_s()   + ','
      result += 'virtual_eth_adapters=' + self.virtual_eth_adapters_to_s()    + ','
      result += "vtpm_adapters=#{@vtpm_adapters_raw},"         unless @vtpm_adapters_raw == nil
      result += 'virtual_fc_adapters' + self.virtual_fc_adapters_to_s()     + ',' unless @virtual_fc_adapters_raw == nil
      result += "sni_device_ids=#{@sni_device_ids},"      unless @sni_device_ids == nil
      result += self.hca_adapters_to_s() + ','
      result += "boot_mode=#{@boot_mode},conn_monitoring=#{@conn_monitoring},auto_start=#{@auto_start},"
      result += "power_ctrl_lpar_ids=#{@power_ctrl_lpar_ids},work_group_id=#{@work_group_id},"
      result += "redundant_err_path_reporting=#{@redundant_err_path_reporting}"
      result += ",bsr_arrays=#{@bsr_arrays}"                              unless @bsr_arrays == nil
      result += ",lpar_proc_compat_mode=#{@lpar_proc_compat_mode}"      unless @lpar_proc_compat_mode == nil
      result += ",electronic_err_reporting=#{@electronic_err_reporting}" unless @electronic_err_reporting == nil
    else
       raise "unknown compatibility, default is Power5"
    end

      result
  end

 # the result of command it the same as: lssyscfg -r prof -m $FRAME
  def to_s_F params='all'

      result_array    = []
      params_to_print = []

      if params == 'all'
        params_to_print = @_parametr_order
      else
        params_to_print = params.split(',')
      end

      params_with_functions = [ 'io_slots', 'virtual_serial_adapters', 'virtual_scsi_adapters', 'virtual_eth_adapters', 'hca_adapters',
                                'vtpm_adapters', 'virtual_fc_adapters', 'lhea_logical_ports', 'virtual_vasi_adapters',
                                'sriov_eth_logical_ports', 'virtual_eth_vsi_profiles']

      params_to_print.each { |parametr|

          if  params_with_functions.include?(parametr)
              tmp = parametr + '=' + self.adapters_to_s_F(parametr)
              if tmp.include?('"') or tmp.include?(',')
                tmp = '"' + tmp + '"'
              end
              result_array.push(tmp)
          else
            result_array.push (parametr + '=' + self.instance_variable_get("@#{parametr}").to_s)
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
		result = "mksyscfg -r lpar -m #{@sys} -i \"name=#{@lpar_name},lpar_id=#{@lpar_id},profile_name=#{@name},"
		result += "lpar_env=#{@lpar_env},shared_proc_pool_util_auth=#{@shared_proc_pool_util_auth},min_mem=#{@min_mem},"
		result += "desired_mem=#{@desired_mem},max_mem=#{@max_mem},proc_mode=#{@proc_mode},"
		result += "min_proc_units=#{@min_proc_units},desired_proc_units=#{@desired_proc_units},max_proc_units=#{@max_proc_units},"
		result += "min_procs=#{@min_procs},desired_procs=#{@desired_procs}, max_procs=#{@max_procs},"
		result += "sharing_mode=#{@sharing_mode},uncap_weight=#{@uncap_weight},boot_mode=#{@boot_mode},"
		result += "conn_monitoring=#{@conn_monitoring},shared_proc_pool_util_auth=#{@shared_proc_pool_util_auth}"
		result += ",lpar_io_pool_ids=#{@lpar_io_pool_ids},"
		result += "max_virtual_slots=#{@max_virtual_slots}"

		result += ',io_slots=none';
		
		if (@virtual_eth_adapters.size == 0) 
			result +=  ',virtual_eth_adapters=none'
		 else 
			result +=  ",\"\\\"virtual_eth_adapters="
			adapters=[] 
			@virtual_eth_adapters.each { |adapter|
				adapters.push(adapter.to_s)
			}
			result += adapters.join(',')
			result +=  "\"\\\""
		end
		
		if (@virtual_scsi_adapters.size == 0) 
			result +=  ',virtual_scsi_adapters=none'
		else 
			result +=  ",\"\\\"virtual_scsi_adapters="
			adapters=[] 
			@virtual_scsi_adapters.each { |adapter|
				adapters.push(adapter.to_s)
			}
			result += adapters.join(',')
			result +=  "\"\\\""
		end

		result += '"'
		
		result 
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
        #pp @lhea_logical_ports_raw
        #pp @lhea_logical_ports
        #raise "lhea_logical ports issue"
      end
    end

		#TODO: make decode code for @hca_adapters

	
	end
end