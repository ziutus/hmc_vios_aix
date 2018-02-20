require 'pp'
require 'HMC/HmcString'
require 'HMC/Lpar_virtual_slots'
require 'HMC/Lpar_IO_slot'

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

  attr_reader :lhea_logical_ports_raw
  attr_accessor :vtpm_adapters_raw
  attr_accessor :hca_adapters_raw
  attr_accessor :sriov_eth_logical_ports_raw


  attr_reader :virtual_vasi_adapters
  attr_reader :virtual_eth_vsi_profiles

  attr_accessor :virtual_vasi_adapters_raw
  attr_reader   :virtual_eth_vsi_profiles_raw

  attr_accessor :sni_device_ids

  #taken from: https://www.ibm.com/support/knowledgecenter/en/POWER8/p8edm/lssyscfg.html (see description of -F parameter)
  attr_reader :sriov_eth_logical_ports_raw
  attr_reader :sriov_eth_logical_ports
  attr_reader :vnic_adapters_raw
  attr_reader :vnic_adapters


   # own attributes
  attr_accessor :_compatibility
  attr_reader   :_parametr_order
  attr_reader   :_default_params

  attr_reader   :virtual_slots

	def initialize(lpar_id='', profile_name='normal')

    string = ''

    if lpar_id.class.to_s == 'String'
      if lpar_id.include?('=')
        string = lpar_id
        lpar_id = ''
      end
    end


    @lpar_id = lpar_id
    @name    = profile_name

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


    @_variables['string_raw'] = %w( hca_adapters vtpm_adapters virtual_vasi_adapters virtual_eth_vsi_profiles sriov_eth_logical_ports vnic_adapters
         sriov_eth_logical_ports
)

    @_variables['string_virtual_raw'] = %w(virtual_serial_adapters virtual_scsi_adapters virtual_eth_adapters virtual_fc_adapters)

    @_functions_self = %w(io_slots hca_adapters vtpm_adapters lhea_logical_ports sriov_eth_logical_ports virtual_vasi_adapters virtual_eth_vsi_profiles
      vnic_adapters)
    @_functions_virtual_slots = %w( virtual_serial_adapters virtual_scsi_adapters virtual_eth_adapters  virtual_fc_adapters)



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
    @virtual_slots.profile_name=@name

    if string.length > 0
      self.parse(string)
    end

  end

  def adapter_add(adapter)

    case adapter.class.to_s
      when 'VirtualEthAdapter'    then self.virtual_slots.virtual_eth_adapters_add(adapter)
      when 'VirtualScsiAdapter'   then self.virtual_slots.virtual_scsi_adapters_add(adapter)
      when 'VirtualSerialAdapter' then self.virtual_slots.virtual_serial_adapters_add(adapter)
      when 'VirtualFCAdapter'     then self.virtual_slots.virtual_fc_adapters_add(adapter)
      else
        pp 'adapter class:' +  adapter.class
        raise 'unknown type of Virtual Adapter'
    end
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

  def vnic_adapters_to_s
    #TODO: it should have separate class of each adapter and function to analyze it (not used now on my Power5, found in manual on IBM site)
    unless @vnic_adapters_raw.nil?
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


    params_to_print.each {|parametr|

      if @_functions_self.include?(parametr)

        tmp = self.send("#{parametr}_to_s")
        tmp = make_string(parametr, tmp)
        result_array.push(tmp) unless tmp.nil?

      elsif @_functions_virtual_slots.include?(parametr)

          tmp = @virtual_slots.send("#{parametr}_to_s")
          tmp = make_string(parametr, tmp)
          result_array.push(tmp) unless tmp.nil?

      else
        unless self.instance_variable_get("@#{parametr}") == nil
          result_array.push (make_string(parametr, self.instance_variable_get("@#{parametr}").to_s))
        end
      end
    }

    result_array.join(',')
  end

  def vlans
    result = []
    self.virtual_slots.virtual_eth_adapters.each { |adapter|
      result.push(adapter.portVlanID)
      adapter.additionalVlanIDs.split(',').each { |vlan|
        result.push(vlan)
      }
    }
    result.sort
  end

  def mksyscfg_cmd
		"mksyscfg -r lpar -m #{@sys} -i \"" + self.to_s + '"'
	end


	def remove_cmd
		"rmsyscfg -m #{@sys} -r lpar -n #{@lpar_name}"
	end


	def lssyscfgProfDecode(string)

    string.gsub!("\n", '')
    string.gsub!("\r", '')

    HmcString.parse(string).each {|name, value|

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

    @virtual_slots.profile_name=@name

    if self.to_s != string
      puts 'Incoming string:'
      pp string
      puts 'Analysed data as result of to_s:'
      puts self.to_s
      raise 'wrong parsing of profile string'
    end

  end

   alias :parse :lssyscfgProfDecode


  def io_slots_raw=(string)
      if string != 'none'
        string.split(',').each { |adapter_string|
          @io_slots.push(Lpar_IO_slot.new(adapter_string))
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

  def diff_show (another_profile, columns_to_compare = 'all', columns_to_ignore = 'none')

    diffs = Hash.new
    ignore = columns_to_ignore.split(',')
    compare = columns_to_compare.split(',')

    @_variables.keys.each { |type|

      if type == 'string_virtual_raw'
        diffs.merge!(self.virtual_slots.diff(another_profile.virtual_slots))
        next
      end

      @_variables[type].each { |name|

        next if ignore.include?(name)
        next if columns_to_compare != 'all' and ! compare.include?(name)

        val_self    = self.instance_variable_get("@#{name}")
        val_profile = another_profile.instance_variable_get("@#{name}")

        if val_self != val_profile
          val_self    = 'nil' if val_self.nil?
          val_profile = 'nil' if val_profile.nil?

          difference = Hash.new
          difference[another_profile.name] = val_profile
          difference[self.name]            = val_self

          diffs[name] =  difference
        end

      }
    }

    diffs
  end

end