require 'pp'
require 'HMC/HmcString'
require 'HMC/Lpar_virtual_slots'

include HmcString

class Lpar_profile

	attr_accessor :sys
  attr_accessor :name
  attr_accessor :lpar_name

  attr_accessor :lpar_id
  attr_accessor :lpar_env
  attr_accessor :all_resources
  attr_accessor :min_mem
  attr_accessor :desired_mem
  attr_accessor :max_mem
  attr_accessor :mem_mode
  attr_accessor :hpt_ratio
  attr_accessor :min_num_huge_pages
  attr_accessor :desired_num_huge_pages
  attr_accessor :max_num_huge_pages

  attr_accessor :proc_mode
  attr_accessor :min_proc_units
  attr_accessor :desired_proc_units
  attr_accessor :max_proc_units
  attr_accessor :min_procs
  attr_accessor :desired_procs
  attr_accessor :max_procs

  attr_accessor :sharing_mode
  attr_accessor :uncap_weight
  attr_accessor :lpar_io_pool_ids
  attr_accessor :lpar_io_pool_ids_raw
  attr_accessor :max_virtual_slots

  attr_accessor :auto_start
  attr_accessor :conn_monitoring

  attr_accessor :resource_config
  attr_accessor :os_version
  attr_accessor :logical_serial_num
  attr_accessor :default_profile
  attr_accessor :curr_profile
  attr_accessor :work_group_id
  attr_accessor :shared_proc_pool_util_auth
  attr_accessor :allow_perf_collection
  attr_accessor :power_ctrl_lpar_ids
  attr_accessor :boot_mode
  attr_accessor :lpar_keylock
  attr_accessor :redundant_err_path_reporting
  attr_accessor :rmc_state
  attr_accessor :rmc_ipaddr
  attr_accessor :sync_curr_profile

  attr_accessor :mem_expansion
  attr_accessor :affinity_group_id
  attr_accessor :bsr_arrays
  attr_accessor :lpar_proc_compat_mode
  attr_accessor :lhea_capabilities
  attr_accessor :lpar_proc_compat_mode
  attr_accessor :electronic_err_reporting

  attr_reader :io_slots
  attr_reader :io_slots_raw

  # ports
  attr_reader :sriov_eth_logical_ports
  attr_reader :lhea_logical_ports
  attr_reader :vtpm_adapters
  attr_reader :hca_adapters

  attr_accessor :lhea_logical_ports_raw
  attr_accessor :vtpm_adapters_raw
  attr_accessor :hca_adapters_raw
  attr_accessor :sriov_eth_logical_ports_raw


  attr_reader :virtual_vasi_adapters
  attr_reader :virtual_eth_vsi_profiles

  attr_accessor :virtual_vasi_adapters_raw
  attr_reader   :virtual_eth_vsi_profiles_raw

  attr_accessor :sni_device_ids

   # own attributes
  attr_accessor :_compatibility
  attr_reader   :_parametr_order
  attr_reader   :_default_params

  attr_reader   :virtual_slots

	def initialize(lpar_id='', name='normal')

    @lpar_id = lpar_id
    @name    = name

    @_variables = Hash.new
    @_variables['variables_int'] = %w(lpar_id min_mem desired_mem max_mem all_resources min_procs desired_procs max_procs max_virtual_slots
            auto_start conn_monitoring uncap_weight bsr_arrays shared_proc_pool_id)
    @_variables['variables_float'] = %w(min_proc_units desired_proc_units max_proc_units mem_expansion)

    @_variables['string'] = ['name', 'lpar_name', 'lpar_env', 'mem_mode', 'proc_mode', 'sharing_mode',
                         'lpar_io_pool_ids', 'boot_mode',
                         'power_ctrl_lpar_ids', 'work_group_id', 'redundant_err_path_reporting', 'hpt_ratio',
                         'affinity_group_id', 'lhea_capabilities' 'lpar_proc_compat_mode', 'lhea_capabilities', 'lpar_proc_compat_mode',
                         'electronic_err_reporting', 'min_num_huge_pages', 'desired_num_huge_pages', 'max_num_huge_pages',
                         'shared_proc_pool_name', 'sni_device_ids']


    @_variables['string_raw'] = %w( hca_adapters vtpm_adapters virtual_vasi_adapters virtual_eth_vsi_profiles sriov_eth_logical_ports vnic_adapters)

    @_variables['string_virtual_raw'] = %w(virtual_serial_adapters virtual_scsi_adapters virtual_eth_adapters virtual_fc_adapters)


    @_default_params = Hash.new

    @_default_params['power5'] = %w{name lpar_name lpar_id lpar_env all_resources min_mem desired_mem max_mem min_num_huge_pages
      desired_num_huge_pages max_num_huge_pages mem_mode hpt_ratio proc_mode min_proc_units
      desired_proc_units max_proc_units min_procs desired_procs max_procs sharing_mode uncap_weight
      io_slots lpar_io_pool_ids max_virtual_slots virtual_serial_adapters virtual_scsi_adapters virtual_eth_adapters
      hca_adapters boot_mode conn_monitoring auto_start power_ctrl_lpar_ids work_group_id redundant_err_path_reporting }

    @lhea_logical_ports = []
    @hca_adapters = []
    @io_slots = []

    @_compatibility = 'power5'
    @_parametr_order = []

    @sriov_eth_logical_ports = nil
    @vtpm_adapters = nil
    @virtual_vasi_adapters = nil
    @virtual_eth_vsi_profiles = nil

    @hca_adapters_raw = nil
    @vtpm_adapters_raw = nil
    @virtual_eth_vsi_profiles_raw = nil
    @virtual_vasi_adapters_raw = nil
    @sriov_eth_logical_ports_raw = nil
    @sys  = nil
    @lpar_name = nil


    @virtual_slots = Lpar_virtual_slots.new

  end

  def io_slots_to_s

    result = nil
    unless @io_slots_raw.nil?
      if @io_slots.size == 0
        result =  'none'
      elsif @io_slots.size == 1
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
  def to_s(params='all', exclude_cols='none')

    result_array = []

    if params == 'all'
      if @_parametr_order.count > 0
        params_to_print = @_parametr_order
      else
        params_to_print = @_default_params[@_compatibility]
      end
    else
      params_to_print = params.split(',')
    end

    if exclude_cols != 'none'
        exclude_cols.split(',').each { |column|
          params_to_print.delete(column)
        }
    end

    params_with_functions = %w(io_slots virtual_serial_adapters virtual_scsi_adapters virtual_eth_adapters hca_adapters vtpm_adapters virtual_fc_adapters
                                  lhea_logical_ports virtual_vasi_adapters sriov_eth_logical_ports virtual_eth_vsi_profiles)

    params_to_print.each {|parametr|

      if params_with_functions.include?(parametr)

        tmp = case parametr
                   when 'io_slots'                 then self.io_slots_to_s
                   when 'sriov_eth_logical_ports'  then self.sriov_eth_logical_ports_to_s
                   when 'hca_adapters'             then self.hca_adapters_to_s
                   when 'vtpm_adapters'            then self.vtpm_adapters_to_s
                   when 'lhea_logical_ports'       then self.lhea_logical_ports_to_s
                   when 'virtual_vasi_adapters'    then self.virtual_vasi_adapters_to_s
                   when 'virtual_eth_vsi_profiles' then self.virtual_eth_vsi_profiles_to_s
                   when 'virtual_fc_adapters'      then @virtual_slots.adapters_to_s('virtual_fc_adapters')
                   when 'virtual_serial_adapters'  then @virtual_slots.adapters_to_s('virtual_serial_adapters')
                   when 'virtual_scsi_adapters'    then @virtual_slots.adapters_to_s('virtual_scsi_adapters')
                   when 'virtual_eth_adapters'     then @virtual_slots.adapters_to_s('virtual_eth_adapters')
                   else
                     raise 'class:lpar_profile, function:adapters_to_s_F unknown type'
                 end

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

  def get_mksyscfg
		"mksyscfg -r lpar -m #{@sys} -i \"" + self.to_s + '"'
	end

	def remove
		"rmsyscfg -m #{@sys} -r lpar -n #{@lpar_name}"
	end
	
	def lssyscfgProfDecode(string)

    HmcString.parse(string).each {|name, value|

#      puts "#{name}: #{value}"

      if @_variables['variables_int'].include?(name)
        instance_variable_set("@#{name}", value.to_i)
      elsif @_variables['variables_float'].include?(name)
        instance_variable_set("@#{name}", value.to_f)
      elsif @_variables['string_virtual_raw'].include?(name)

        case name
          when 'virtual_fc_adapters'     then @virtual_slots.virtual_fc_adapters_raw = value
          when 'virtual_eth_adapters'    then @virtual_slots.virtual_eth_adapters_raw = value
          when 'virtual_scsi_adapters'   then @virtual_slots.virtual_scsi_adapters_raw = value
          when 'virtual_serial_adapters' then @virtual_slots.virtual_serial_adapters_raw = value
          else
            raise 'unknown virtual slot type' + name
        end
      elsif name == 'io_slots'
        self.io_slots_raw = value
      elsif name == 'lhea_logical_ports'
        self.lhea_logical_ports_raw = value
      elsif  @_variables['string_raw'].include?(name)
        instance_variable_set("@#{name}_raw", value.to_s)
      elsif @_variables['string'].include?(name)
        instance_variable_set("@#{name}", value.to_s)
      else
        print "unknown name: #{name} with value #{value}"
        raise
      end

      @_parametr_order.push(name)
    }

  end


  def io_slots_raw=(string)
      if string != 'none'
        string.split(',').each { |adapter_string|
          @io_slots.push(adapter_string.split('/'))
        }
      end
      @io_slots_raw = string
  end

  def lhea_logical_ports_raw=(string)
      if string != 'none'
        string.split(',').each { |adapter_string|
          @lhea_logical_ports.push(adapter_string.split('/'))
        }
      end
      @lhea_logical_ports_raw = string
  end

  def ==(another_profile)
    self.to_s == another_profile.to_s
  end

  def diff_show (another_profile, calls_to_ignore)

    diffs = []
    ignore = calls_to_ignore.split(',')

    @_variables.keys.each { |type|
      @_variables[type].each { |name|

        next if ignore.include?(name)

        if type == 'string_virtual_raw'
          val_self    = self.virtual_slots.adapters_to_s(name)
          val_profile = another_profile.virtual_slots.adapters_to_s(name)
        else
          val_self    = self.instance_variable_get("@#{name}")
          val_profile = another_profile.instance_variable_get("@#{name}")
        end

        if val_self != val_profile
          val_self    = 'nil' if val_self.nil?
          val_profile = 'nil' if val_profile.nil?

          message = "#{name}: >" + val_self.to_s + '< vs >' + val_profile.to_s + '<'
          diffs.push(message )
        end
      }
    }

    diffs
  end

end