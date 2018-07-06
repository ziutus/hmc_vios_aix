require 'HMC/HmcString'
require 'HMC/VirtualEthAdapter'
require 'HMC/VirtualScsiAdapter'
require 'HMC/VirtualSerialAdapter'
require 'HMC/VirtualFCAdapter'

include HmcString

class Lpar_virtual_slots

  attr_accessor :virtual_slots

  attr_accessor :max_virtual_slots

  # TODO: implement functions for virtual vasi and vsi adapters
  attr_reader :virtual_vasi_adapters
  attr_reader :virtual_eth_vsi_profiles
  attr_accessor :virtual_vasi_adapters_raw
  attr_accessor :virtual_eth_vsi_profiles_raw

  attr_reader :virtual_fc_adapters
  attr_reader :virtual_serial_adapters
  attr_reader :virtual_scsi_adapters
  attr_reader :virtual_eth_adapters

  attr_reader :virtual_fc_adapters_raw
  attr_reader :virtual_serial_adapters_raw
  attr_reader :virtual_scsi_adapters_raw
  attr_reader :virtual_eth_adapters_raw

  attr_accessor :profile_name # it is helper for diff functions, much easier to say, which profile has different settings

  # TODO: check max virtual slots number
  def initialize(max_virtual_slots = 65_000)
    @max_virtual_slots = max_virtual_slots
    @virtual_slots = {}

    @virtual_vasi_adapters    = []
    @virtual_eth_vsi_profiles = []
    @virtual_vasi_adapters_raw    = nil
    @virtual_eth_vsi_profiles_raw = nil

    @virtual_fc_adapters      = []
    @virtual_scsi_adapters    = []
    @virtual_serial_adapters  = []
    @virtual_eth_adapters     = []

    @virtual_fc_adapters_raw      = nil
    @virtual_scsi_adapters_raw    = nil
    @virtual_serial_adapters_raw  = nil
    @virtual_eth_adapters_raw     = nil

    @profile_name = nil
  end

  def virtual_adapter_add(adapter)

    case adapter.class.to_s
    when 'VirtualEthAdapter'    then virtual_eth_adapters_add(adapter)
    when 'VirtualScsiAdapter'   then virtual_scsi_adapters_add(adapter)
    when 'VirtualSerialAdapter' then virtual_serial_adapters_add(adapter)
    when 'VirtualFCAdapter'     then virtual_fc_adapters_add(adapter)
    else
      pp 'adapter class:' +  adapter.class
      raise 'unknown type of adapter'
    end
  end

  alias add virtual_adapter_add

  def virtual_eth_adapters_add(adapter)
    @virtual_eth_adapters.push(adapter)
    @virtual_slots[adapter.virtualSlotNumber] = adapter

    if @virtual_eth_adapters_raw.nil?
      @virtual_eth_adapters_raw = adapter.to_s
    else
      @virtual_eth_adapters_raw += adapter.to_s
    end
  end

  def virtual_fc_adapters_add(adapter)
    @virtual_fc_adapters.push(adapter)
    @virtual_slots[adapter.virtualSlotNumber] = adapter

    if @virtual_fc_adapters_raw.nil?
      @virtual_fc_adapters_raw = adapter.to_s + ','
    else
      @virtual_fc_adapters_raw += adapter.to_s + ','
    end
  end

  def virtual_scsi_adapters_add(adapter)
    @virtual_scsi_adapters.push(adapter)
    @virtual_slots[adapter.virtualSlotNumber] = adapter

    if @virtual_scsi_adapters_raw.nil?
      @virtual_scsi_adapters_raw = adapter.to_s + ','
    else
      @virtual_scsi_adapters_raw += adapter.to_s + ','
    end
  end

  def virtual_serial_adapters_add(adapter)
    @virtual_serial_adapters.push(adapter)
    # TODO: add this part of code
    # @virtual_slots[adapter.virtualSlotNumber] = adapter

    if @virtual_serial_adapters_raw.nil?
      @virtual_serial_adapters_raw = adapter.to_s + ','
    else
      @virtual_serial_adapters_raw += adapter.to_s + ','
    end
  end

  def virtual_adapters_raw(string, adapter_type)

    unless string == 'none'
      HmcString.parse_value(string).each do |adapter|
        case adapter_type
        when 'virtual_fc_adapters' then virtual_adapter_add(VirtualFCAdapter.new(adapter))
        when 'virtual_eth_adapters' then virtual_adapter_add(VirtualEthAdapter.new(adapter))
        when 'virtual_scsi_adapters' then virtual_adapter_add(VirtualScsiAdapter.new(adapter))
        when 'virtual_serial_adapters' then virtual_adapter_add(VirtualSerialAdapter.new(adapter))
        else
          raise 'unknown type of virtual adapter'
        end
      end
    end

    case adapter_type
    when 'virtual_fc_adapters' then @virtual_fc_adapters_raw = string
    when 'virtual_eth_adapters' then @virtual_eth_adapters_raw = string
    when 'virtual_scsi_adapters' then @virtual_scsi_adapters_raw = string
    when 'virtual_serial_adapters' then @virtual_serial_adapters_raw = string
    else
      raise 'unknown type of virtual adapter'
    end
  end

  def virtual_serial_adapters_raw=(string)
    virtual_adapters_raw(string, 'virtual_serial_adapters')
  end

  def virtual_eth_adapters_raw=(string)
    virtual_adapters_raw(string, 'virtual_eth_adapters')
  end

  def virtual_scsi_adapters_raw=(string)
    virtual_adapters_raw(string, 'virtual_scsi_adapters')
  end

  def virtual_fc_adapters_raw=(string)
    virtual_adapters_raw(string, 'virtual_fc_adapters')
  end

  def adapters_to_s(type)

    return nil if type == 'virtual_fc_adapters'     && @virtual_fc_adapters_raw.nil?
    return nil if type == 'virtual_eth_adapters'    && @virtual_eth_adapters_raw.nil?
    return nil if type == 'virtual_serial_adapters' && @virtual_serial_adapters_raw.nil?
    return nil if type == 'virtual_scsi_adapters'   && @virtual_scsi_adapters_raw.nil?

    adapters_tmp = case type
                   when 'virtual_fc_adapters'     then @virtual_fc_adapters
                   when 'virtual_eth_adapters'    then @virtual_eth_adapters
                   when 'virtual_scsi_adapters'   then @virtual_scsi_adapters
                   when 'virtual_serial_adapters' then @virtual_serial_adapters
                   else
                     raise 'unknown type ' + type
   end

    if adapters_tmp.empty?
      'none'
    else
      adapters = []
      adapters_tmp.each do |adapter|
        adapters.push(adapter.to_s)
      end
      adapters.join(',')
    end
  end

  def virtual_fc_adapters_to_s
    adapters_to_s('virtual_fc_adapters')
  end

  def virtual_scsi_adapters_to_s
    adapters_to_s('virtual_scsi_adapters')
  end

  def virtual_eth_adapters_to_s
    adapters_to_s('virtual_eth_adapters')
  end

  def virtual_serial_adapters_to_s
    adapters_to_s('virtual_serial_adapters')
  end

  def diff(other_lpar_virtual_slots, type)

    diff = {}
    max_virtual_slots = self.max_virtual_slots > other_lpar_virtual_slots.max_virtual_slots ? self.max_virtual_slots : other_lpar_virtual_slots.max_virtual_slots

    1.upto(max_virtual_slots) do |i|
      if virtual_slots.key?(i) && other_lpar_virtual_slots.virtual_slots.key?(i)

          self_slot =  virtual_slots[i]
          other_slot = other_lpar_virtual_slots.virtual_slots[i]
          self_profile_name = profile_name
          other_profile_name = other_lpar_virtual_slots.profile_name

          # let's check type of slots
          if type == 'virtual_serial_adapters'
            next unless self_slot.class.name == 'VirtualSerialAdapter' or other_slot.class.name == 'VirtualSerialAdapter'
          elsif type == 'VirtualScsiAdapter'
            next unless self_slot.class.name == 'VirtualScsiAdapter' or other_slot.class.name == 'VirtualScsiAdapter'
          elsif type == 'virtual_eth_adapters'
            next unless self_slot.class.name == 'VirtualEthAdapter' or other_slot.class.name == 'VirtualEthAdapter'
          elsif type == 'virtual_fc_adapters'
            next unless self_slot.class.name == 'VirtualFCAdapter' or other_slot.class.name == 'VirtualFCAdapter'
          end

          # let's check if slot are the same type (ethernet, fcs etc)
          if self_slot.class.name != other_slot.class.name
            entry = {}
            entry[self_profile_name] =  "The slot type is #{self_slot.class.name}"
            entry[other_profile_name] = "The slot type is #{other_slot.class.name}"
            diff["VirtualSlot #{i}"] = entry

            next
          end

          if self_slot.class.name == 'VirtualFCAdapter' ||
             self_slot.class.name == 'VirtualEthAdapter' ||
             self_slot.class.name == 'VirtualScsiAdapter'

            diff_entry_slot = self_slot.diff(other_slot, self_profile_name, other_profile_name)

            diff_entry_slot.each do |key, entry_tmp|
              diff["VirtualSlot #{i} #{key}"] = entry_tmp
            end
          else
            raise("unsupported type of adapter #{self_slot.class.name} ")
          end


      elsif virtual_slots.key?(i) && !other_lpar_virtual_slots.virtual_slots.key?(i)

        self_slot = virtual_slots[i]
        self_profile_name = profile_name
        other_profile_name = other_lpar_virtual_slots.profile_name

        # let's check type of slots
        if type == 'virtual_serial_adapters'
          next unless self_slot.class.name == 'VirtualSerialAdapter'
        elsif type == 'VirtualScsiAdapter'
          next unless self_slot.class.name == 'VirtualScsiAdapter'
        elsif type == 'virtual_eth_adapters'
          next unless self_slot.class.name == 'VirtualEthAdapter'
        elsif type == 'virtual_fc_adapters'
          next unless self_slot.class.name == 'VirtualFCAdapter'
        end


        entry = {}
        entry[self_profile_name]  = "A profile use it: #{self_slot.class.name} #{self_slot.to_s}"
        entry[other_profile_name] = "A profile doesn't use slot"
        diff["VirtualSlot #{i}"] = entry
      elsif !virtual_slots.key?(i) && other_lpar_virtual_slots.virtual_slots.key?(i)

        other_slot = other_lpar_virtual_slots.virtual_slots[i]
        self_profile_name = profile_name
        other_profile_name = other_lpar_virtual_slots.profile_name

        # let's check type of slots
        if type == 'virtual_serial_adapters'
          next unless other_slot.class.name == 'VirtualSerialAdapter'
        elsif type == 'VirtualScsiAdapter'
          next unless other_slot.class.name == 'VirtualScsiAdapter'
        elsif type == 'virtual_eth_adapters'
          next unless other_slot.class.name == 'VirtualEthAdapter'
        elsif type == 'virtual_fc_adapters'
          next unless other_slot.class.name == 'VirtualFCAdapter'
        end

        entry = {}
        entry[self_profile_name]  = "A profile doesn't use slot"
        entry[other_profile_name] = 'A profile use it: ' + other_slot.class.name + ' ' + other_slot.to_s

        diff["VirtualSlot #{i}"] = entry
      end
    end

    diff
  end

end