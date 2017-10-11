require 'HMC/HmcString'
require 'HMC/VirtualEthAdapter'
require 'HMC/VirtualScsiAdapter'
require 'HMC/VirtualSerialAdapter'
require 'HMC/VirtualFCAdapter'

include HmcString

class Lpar_virtual_slots

  attr_accessor :virtual_slots

  attr_accessor :max_virtual_slots

  #TODO: implement functions for virtual vasi and vsi adapters
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

  #TODO: check max virtual slots number
  def initialize(max_virtual_slots = 65000)
    @max_virtual_slots = max_virtual_slots
    @virtual_slots = Hash.new

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

  end


  def virtual_adapter_add(adapter)

    case adapter.class.to_s
      when 'VirtualEthAdapter'    then self.adapter_virtual_eth_add(adapter)
      when 'VirtualScsiAdapter'   then self.adapter_virtual_scsi_add(adapter)
      when 'VirtualSerialAdapter' then self.adapter_virtual_serial_add(adapter)
      when 'VirtualFCAdapter'     then self.adapter_virtual_fc_add(adapter)
      else
        pp 'adapter class:' +  adapter.class
        raise 'unknown type of Virtual Adapter'
    end
  end

  def adapter_virtual_eth_add(adapter)
    @virtual_eth_adapters.push(adapter)
    if @virtual_eth_adapters_raw.nil?
      @virtual_eth_adapters_raw = adapter.to_s
    else
      @virtual_eth_adapters_raw += adapter.to_s
    end
  end

  def adapter_virtual_fc_add(adapter)
    @virtual_fc_adapters.push(adapter)
    if @virtual_fc_adapters_raw.nil?
      @virtual_fc_adapters_raw = adapter.to_s + ','
    else
      @virtual_fc_adapters_raw += adapter.to_s + ','
    end
  end

  def adapter_virtual_scsi_add(adapter)
    @virtual_scsi_adapters.push(adapter)
    if @virtual_scsi_adapters_raw.nil?
      @virtual_scsi_adapters_raw = adapter.to_s + ','
    else
      @virtual_scsi_adapters_raw += adapter.to_s + ','
    end
  end

  def adapter_virtual_serial_add(adapter)
    @virtual_serial_adapters.push(adapter)
    if @virtual_serial_adapters_raw.nil?
      @virtual_serial_adapters_raw = adapter.to_s + ','
    else
      @virtual_serial_adapters_raw += adapter.to_s + ','
    end
  end

  def virtual_adapters_raw(string, adapter_type)

    unless string == 'none'
      HmcString.parse_value(string).each { |adapter|
        case adapter_type
          when 'virtual_fc_adapters'  then self.virtual_adapter_add(VirtualFCAdapter.new(adapter))
          when 'virtual_eth_adapters'   then self.virtual_adapter_add(VirtualEthAdapter.new(adapter))
          when 'virtual_scsi_adapters'  then self.virtual_adapter_add(VirtualScsiAdapter.new(adapter))
          when 'virtual_serial_adapters' then self.virtual_adapter_add(VirtualSerialAdapter.new(adapter))
          else
            raise 'unknown type of virtual adapter'
        end
      }
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
    self.virtual_adapters_raw(string, 'virtual_serial_adapters')
  end

  def virtual_eth_adapters_raw=(string)
    self.virtual_adapters_raw(string, 'virtual_eth_adapters')
 end

  def virtual_scsi_adapters_raw=(string)
    self.virtual_adapters_raw(string, 'virtual_scsi_adapters')
  end

  def virtual_fc_adapters_raw=(string)
    self.virtual_adapters_raw(string, 'virtual_fc_adapters')
  end

  def adapters_to_s(type)

    return nil if type == 'virtual_fc_adapters'     and @virtual_fc_adapters_raw.nil?
    return nil if type == 'virtual_eth_adapters'    and @virtual_eth_adapters_raw.nil?
    return nil if type == 'virtual_serial_adapters' and @virtual_serial_adapters_raw.nil?
    return nil if type == 'virtual_scsi_adapters'   and @virtual_scsi_adapters_raw.nil?

    adapters_tmp = case type
                     when 'virtual_fc_adapters'     then @virtual_fc_adapters
                     when 'virtual_eth_adapters'    then @virtual_eth_adapters
                     when 'virtual_scsi_adapters'   then @virtual_scsi_adapters
                     when 'virtual_serial_adapters' then @virtual_serial_adapters
                     else
                       raise 'unknown type ' + type
   end

    if adapters_tmp.size == 0
      'none'
    else
      adapters=[]
      adapters_tmp.each {|adapter|
        adapters.push(adapter.to_s)
      }
      adapters.join(',')
    end
  end

  def virtual_fc_adapters_to_s
    self.adapters_to_s('virtual_fc_adapters')
  end

  def virtual_scsi_adapters_to_s
    self.adapters_to_s('virtual_scsi_adapters')
  end

  def virtual_eth_adapters_to_s
    self.adapters_to_s('virtual_eth_adapters')
  end

  def virtual_serial_adapters_to_s
    self.adapters_to_s('virtual_serial_adapters')
  end


end