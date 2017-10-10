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
    if adapter.class == VirtualEthAdapter
      self.adapter_virtual_eth_add(adapter)
    elsif adapter.class == VirtualScsiAdapter
      self.adapter_virtual_scsi_add(adapter)
    elsif adapter.class == VirtualSerialAdapter
      self.adapter_virtual_serial_add(adapter)
    elsif adapter.class == VirtualFCAdapter
      self.adapter_virtual_fc_add(adapter)
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

  def virtual_serial_adapters_raw=(string)

    if string == 'none'
      @virtual_serial_adapters_raw = 'none'
    else
      string.split(',').each { |adapter|
        self.virtual_adapter_add(VirtualSerialAdapter.new(adapter))
      }
      @virtual_serial_adapters_raw = string
    end
  end

  def virtual_eth_adapters_raw=(string)

  if string == 'none'
      @virtual_eth_adapters_raw = 'none'
    else
      HmcString.parse_value(string).each { |adapter_string|
        self.virtual_adapter_add(VirtualEthAdapter.new(adapter_string))
      }
      @virtual_eth_adapters_raw = string
    end
  end

  def virtual_scsi_adapters_raw=(string)

    if string == 'none'
      @virtual_scsi_adapters_raw = 'none'
    else
      string.split(',').each { |adapter|
        self.virtual_adapter_add(VirtualScsiAdapter.new(adapter))
      }
      @virtual_scsi_adapters_raw = string
    end
  end

  def virtual_fc_adapters_raw=(string)
    if string != 'none'
      HmcString.parse_value(string).each { |adapter_string|
        self.virtual_adapter_add(VirtualFCAdapter.new(adapter_string))
      }
      @virtual_fc_adapters_raw = string
    else
      @virtual_fc_adapters_raw = 'none'
    end

  end


  def adapters_virtual_eth_to_s

    result = nil
    unless @virtual_eth_adapters_raw.nil?
      if @virtual_eth_adapters.size == 0
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

  def adapters_virtual_scsi_to_s

    result = nil
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

  def adapters_virtual_serial_to_s

    result = nil
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

  def adapters_virtual_fc_to_s

    result = nil
    unless @virtual_fc_adapters_raw.nil?
      result = 'virtual_fc_adapters='

      if @virtual_fc_adapters.size == 0
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

end