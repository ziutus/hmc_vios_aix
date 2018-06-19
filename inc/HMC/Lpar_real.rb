require 'pp'
require 'HMC/VirtualEthAdapter'
require 'HMC/VirtualScsiAdapter'
require 'HMC/VirtualSerialAdapter'
require 'HMC/VirtualFCAdapter'

require 'HMC/HmcString'
include HmcString

class Lpar_real
  attr_reader :sys
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

  # power7
  attr_reader :time_ref
  attr_reader :lpar_avail_priority
  attr_reader :remote_restart_capable
  attr_reader :suspend_capable
  attr_reader :desired_lpar_proc_compat_mode
  attr_reader :curr_lpar_proc_compat_mode
  attr_reader :affinity_group_id

  # stolen from https://github.com/vfoucault/powervmtools
  # and from https://www.ibm.com/support/knowledgecenter/en/POWER8/p8edm/mksyscfg.html
  # vtpm_enabled - virtual Trusted Platform Module (enabled or disabled)
  # power8
  attr_reader :vtpm_enabled
  attr_reader :simplified_remote_restart_capable
  attr_reader :remote_restart_status

  # taken from doc for power8: https://www.ibm.com/support/knowledgecenter/en/POWER8/p8edm/mksyscfg.html
  attr_reader :msp                  # mover service partition
  attr_reader :powervm_mgmt_capable # Linux only: allow this partition to provide PowerVM management functions

  # from memory string (lshwres -r mem --level lpar -m $MS)
  attr_reader	:curr_min_mem
  attr_reader :curr_mem
  attr_reader :curr_max_mem
  attr_reader :curr_min_num_huge_pages
  attr_reader :curr_num_huge_pages
  attr_reader	:curr_max_num_huge_pages
  attr_reader :curr_hpt_ratio

  # pending are target values for DLPAR
  attr_reader :pend_min_mem
  attr_reader :pend_mem
  attr_reader :pend_max_mem
  attr_reader :pend_min_num_huge_pages
  attr_reader :pend_num_huge_pages
  attr_reader :pend_max_num_huge_pages

  attr_reader :run_min_mem
  attr_reader :run_mem
  attr_reader :run_num_huge_pages

  attr_reader :mem_mode

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

  # from slots: lshwres -r virtualio --level lpar --rsubtype slot -m $MS
  attr_reader	:curr_max_virtual_slots
  attr_reader :pend_max_virtual_slots
  attr_reader :next_avail_virtual_slot

  attr_reader :adaptersReal
  attr_reader :adaptersVirtual
  attr_reader :virtual_scsi_adapters

  # tmp values, to remove
  attr_reader :_parsed
  attr_accessor :type_model

  # https://www.ibm.com/support/knowledgecenter/HW4P4/p8edm/rsthwres.html

  def initialize(sys = nil,lpar_id = nil,name = nil)

    @lpar_name = nil

    # string from command ''
    @lpar_id = nil
    @allow_perf_collection = nil
    @auto_start = nil
    @shared_proc_pool_util_auth = nil
    @redundant_err_path_reporting = nil
    @sync_curr_profile = nil

    @name     = nil
    @lpar_env = nil
    @state    = nil
    @resource_config = nil
    @os_version      = nil
    @logical_serial_num = nil
    @default_profile = nil
    @curr_profile = nil
    @work_group_id = nil
    @power_ctrl_lpar_ids = nil
    @boot_mode    = nil
    @lpar_keylock = nil
    @rmc_state    = nil
    @rmc_ipaddr   = nil

    @sys = sys
    @name = name
    @lpar_id = lpar_id.to_i unless lpar_id.nil?

    # power7
    @time_ref = nil
    @lpar_avail_priority = nil
    @remote_restart_capable = nil
    @suspend_capable = nil
    @desired_lpar_proc_compat_mode = nil
    @curr_lpar_proc_compat_mode = nil
    @affinity_group_id = nil

    # power8
    @vtpm_enabled                      = nil
    @simplified_remote_restart_capable = nil
    @remote_restart_status             = nil
    @msp                               = nil
    @powervm_mgmt_capable              = nil

    # from memory string
    @curr_min_mem = 0
    @curr_min_mem = 0
    @curr_mem = 0
    @curr_max_mem = 0
    @pend_min_mem = 0
    @pend_mem = 0
    @pend_max_mem = 0
    @run_min_mem = 0
    @run_mem = 0
    @curr_min_num_huge_pages = 0
    @curr_num_huge_pages = 0
    @curr_max_num_huge_pages = 0
    @pend_min_num_huge_pages = 0
    @pend_num_huge_pages = 0
    @pend_max_num_huge_pages = 0
    @run_num_huge_pages = 0
    @mem_mode = ''
    @curr_hpt_ratio = ''

    # from proc string
    @curr_proc_mode = nil
    @curr_min_procs = nil
    @curr_procs = nil
    @curr_max_procs = nil
    @curr_sharing_mode = nil
    @pend_proc_mode = nil
    @pend_min_procs = nil
    @pend_procs = nil
    @pend_max_procs = nil
    @pend_sharing_mode = nil
    @run_procs = nil

    @curr_min_proc_units = nil
    @curr_proc_units = nil
    @curr_max_proc_units = nil
    @curr_uncap_weight = nil
    @curr_shared_proc_pool_id = nil
    @pend_min_proc_units = nil
    @pend_proc_units = nil
    @pend_max_proc_units = nil
    @pend_uncap_weight = nil
    @pend_shared_proc_pool_id = nil
    @run_proc_units = nil
    @run_procs = nil
    @run_uncap_weight = nil

    @adaptersVirtual = {}
    @adaptersReal = []

    @virtual_eth_adapters    = []
    @virtual_scsi_adapters   = []
    @virtual_serial_adapters = []

    @_parsed = {
      'lpar_info' => false,
      'memory' => false,
      'cpu' => false,
      'virtual_slot' => false,
      'virtual_eth' => false,
      'virtual_scsi' => false,
      'virtual_serial' => false,
      'virtual_fc' => false,
    }

    @type_model = nil

    @_variables = {}
    @_variables['variables_int']    = %w[lpar_id allow_perf_collection auto_start shared_proc_pool_util_auth redundant_err_path_reporting sync_curr_profile
      time_ref lpar_avail_priority remote_restart_capable suspend_capable simplified_remote_restart_capable vtpm_enabled msp powervm_mgmt_capable]
    @_variables['variables_string'] = %w[name lpar_env state resource_config os_version logical_serial_num default_profile curr_profile
      work_group_id power_ctrl_lpar_ids boot_mode lpar_keylock rmc_state rmc_ipaddr
      desired_lpar_proc_compat_mode curr_lpar_proc_compat_mode affinity_group_id remote_restart_status ]

    @_variables['memory_int']    = %w[lpar_id curr_min_mem curr_mem curr_max_mem pend_min_mem pend_mem pend_max_mem run_min_mem run_mem curr_min_num_huge_pages
      curr_num_huge_pages curr_max_num_huge_pages pend_min_num_huge_pages pend_num_huge_pages pend_max_num_huge_pages run_num_huge_pages]
    @_variables['memory_string'] = %w[mem_mode]

    @_variables['proc_int']    = %w[lpar_id curr_shared_proc_pool_id curr_min_procs curr_procs curr_max_procs curr_uncap_weight pend_shared_proc_pool_id
        pend_min_procs pend_procs pend_max_procs run_procs pend_uncap_weight run_uncap_weight]
    @_variables['proc_string'] = %w[curr_proc_mode curr_sharing_mode pend_proc_mode pend_sharing_mode]
    @_variables['proc_float']  = %w[curr_min_proc_units pend_min_proc_units pend_proc_units pend_max_proc_units run_proc_units curr_proc_units curr_max_proc_units]
  end

  def start_cmd(profile)
    "chsysstate -m #{@sys} -r lpar -n #{@name} -o on -f #{profile}"
  end

  def stop_cmd
    "chsysstate -m #{@sys} -r lpar -n #{@name} -o shutdown"
  end

  def status_cmd
    "lssyscfg -m #{@sys} -r lpar -F state  --filter='#{@name}'"
  end

  def memory_add_cmd(how_much)
    "chhwres -m #{@sys} -p #{@name} -r mem -o a  -q #{how_much}"
  end

  def memory_remove_cmd(how_much)
    "chhwres -m #{@sys} -p #{@name} -r mem -o r  -q #{how_much}"
  end

  def proc_units_add_cmd(how_much)
    "chhwres -m #{@sys} -p #{@name} -r proc -o a --procunits #{how_much}"
  end

  def proc_units_remove_cmd(how_much)
    "chhwres -m #{@sys} -p #{@name} -r proc -o r --procunits #{how_much}"
  end

  def memory_restore_to_profile_cmd
    ''
  end

  def slot_remove_cmd(slot_id)
    "chhwres -r virtualio -m #{@sys} -o  r -p #{@name} -s #{slot_id}"
  end

  def lpar_remove_cmd
    "rmsyscfg -m #{@sys} -r lpar -n #{@name}"
  end

  def lssyscfg_decode(string)

    HmcString.parse(string).each { |name, value|

      if @_variables['variables_int'].include?(name)
        instance_variable_set("@#{name}", value.to_i)
      elsif @_variables['variables_string'].include?(name)
        instance_variable_set("@#{name}", value.to_s)
      else
        print "unknown name: #{name} with value #{value}"
        raise
      end
    }
    @_parsed['lpar_info'] = true
  end

  alias lssyscfgDecode lssyscfg_decode

  def decode_mem(string)

    HmcString.parse(string).each { |name, value|

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
    @_parsed['memory'] = true

  end

  def decode_proc(string)

    HmcString.parse(string).each { |name, value|

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
    @_parsed['cpu'] = true

  end

  def decodeVirtualioSlot(string)

    regexp_slot = /lpar_name=([\w\_\-]+),lpar_id=(\d+),curr_max_virtual_slots=(\d+),pend_max_virtual_slots=(\d+),next_avail_virtual_slot=(\d+)/

    match = regexp_slot.match(string)

    unless match
      puts string
      puts match
      puts "RegExp couldn't decode string >#{string}<"
      raise
    end

    @curr_max_virtual_slots = match[3].to_i
    @pend_max_virtual_slots = match[4].to_i
    @next_avail_virtual_slot = match[5].to_i

    @_parsed['virtual_slot'] = true
  end

  def decode_virtual_scsi(string)

    string.split("\n").each do |line|
      adapter = VirtualScsiAdapter.new
      if adapter.can_parse?(line)
        adapter.parse(line)
        adaptersVirtual[adapter.virtualSlotNumber] = adapter
      end
    end
    @_parsed['virtual_scsi'] = true

  end

  def decode_virtual_serial(string)

    string.split("\n").each do |line|
      adapter = VirtualSerialAdapter.new
      if adapter.can_parse?(line)
        adapter.parse(line)
        adaptersVirtual[adapter.virtualSlotNumber] = adapter
      end
    end

    @_parsed['virtual_serial'] = true
  end



  def decode_virtualio_eth(string)

    string.split(/\n/).each do |line|
      adapter = VirtualEthAdapter.new
      if adapter.can_parse?(line)
        adapter.parse(line)
        adaptersVirtual[adapter.virtualSlotNumber] = adapter if adapter.lpar_id == @lpar_id.to_i
      end
    end

    @_parsed['virtual_eth'] = true
  end

  def virtual_adapter_eth_add(adapter)
    adaptersVirtual[adapter.virtualSlotNumber] = adapter
  end

  def virtual_adapter_remove(slot_id)
    adaptersVirtual.delete(slot_id)
  end

  def virtual_adapter_first_free

    @max_virtual_slots = 10 if @max_virtual_slots.nil?
    @max_virtual_slots = 10 unless @max_virtual_slots > 0
    for i in 0..@max_virtual_slots
      return i unless @adaptersVirtual.key?(i)
    end
  end

  def virtual_adapter_exist?(adapter_id)
    @adaptersVirtual.key?(adapter_id)
  end


  def virtual_adapter_scsi_add(adapter)
    @virtual_scsi_adapters[adapter.virtualSlotNumber] = adapter
  end

  def parsed_all?
    parsed_all = true
    @_parsed.each_pair do |key,value|
      next if @type_model == '9131-52A' and key == 'virtual_fc'
      parsed_all = false if value == false
    end
    parsed_all
  end

end