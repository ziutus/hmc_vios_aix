require 'HMC/virtual_adapter'
require 'HMC/HmcString'

include HmcString

class VirtualEthAdapter < VirtualAdapter

  attr_accessor :isIEEE
  attr_accessor :portVlanID
  attr_accessor :additionalVlanIDs
  attr_accessor :trunkPriority
  attr_accessor :isTrunk
  attr_accessor :virtualSwitch
  attr_accessor :macAddress
  attr_accessor :allowedOsMacAddresses
  attr_accessor :qosPiority

  def initialize(string = '')

    super(string)

    @virtualSlotNumber = nil
    @isIEEE = 0
    @portVlanID = nil
    @additionalVlanIDs = ''
    @isTrunk = 0
    @trunkPriority = 0 #if trunk is true, trunk priority has to to be set up

    @virtualSwitch = nil

    @macAddress = nil
    @allowedOsMacAddresses = nil
    @qosPiority = nil

    @regexp_minimum 			       = %r{^\s*(\d+)/([01])/(\d+)/([\d,]+|)/(\d+)/([01])\s*$}
    @regexp_vswitch 			       = %r{^\s*(\d+)/([01])/(\d+)/([\d,]+|)/(\d+)/([01])/([\w\-]+)\s*$}
    @regexp_mac_address 		     = %r{^\s*(\d+)/([01])/(\d+)/([\d,]+|)/(\d+)/([01])/([\w\-]+)/(\w+|)\s*$}
    @regexp_allowed_mac_address = %r{^\s*(\d+)/([01])/(\d+)/([\d,]+|)/(\d+)/([01])/([\w\-]+)/(\w+|)/([\w,]+|all)\s*$}
    @regexp_qos_priority 	       = %r{^\s*(\d+)/([01])/(\d+)/([\d,]+|)/(\d+)/([01])/([\w\-]+)/(\w+|)/([\w,]+|all)/(\d+|none)\s*$}

    @params = %w[isIEEE portVlanID additionalVlanIDs trunkPriority isTrunk virtualSwitch macAddress allowedOsMacAddresses qosPiority]
    @params_real = %w[lpar_name lpar_id slot_num state is_required is_trunk trunk_priority ieee_virtual_eth port_vlan_id vswitch addl_vlan_ids mac_addr allowed_os_mac_addrs qos_priority]


    parse(string) unless string.empty?
  end

  def validate
    raise 'class: VirtualEthAdapter: function: validation, virtualSlotNumber not defined' unless (@virtualSlotNumber.is_a? Numeric)
    raise 'class: VirtualEthAdapter: function: validation, isIEEE not defined' unless (@isIEEE.is_a? Numeric)
    raise 'class: VirtualEthAdapter: function: validation, isRequired not defined' unless (@isRequired.is_a? Numeric)
  end

  def to_s

    validate

    if @_type == 'real'
      result  = "lpar_name=#{@lpar_name},lpar_id=#{@lpar_id},slot_num=#{@virtualSlotNumber},state=#{@state},is_required=#{@isRequired},"
      result += "is_trunk=#{@isTrunk},"
      result += "trunk_priority=#{@trunkPriority}," if @isTrunk == 1
      result += "ieee_virtual_eth=#{@isIEEE},port_vlan_id=#{@portVlanID},addl_vlan_ids=,mac_addr=#{@macAddress}"
    else
      result = "#{@virtualSlotNumber}/#{@isIEEE}/#{@portVlanID}/#{@additionalVlanIDs}/#{@trunkPriority}/#{@isRequired}"
      result += "/#{@virtualSwitch}" unless @virtualSwitch.nil?
      result += "/#{@macAddress}" unless @macAddress.nil?
      result += "/#{@allowedOsMacAddresses}" unless @allowedOsMacAddresses.nil?
      result += "/#{@qosPiority}" unless @qosPiority.nil?

      result = '""' + result + '""' if result.include?(',')
    end

    result
  end

  def can_parse?(string)

    return true if  @regexp_minimum.match(string)
    return true if  @regexp_vswitch.match(string)
    return true if  @regexp_mac_address.match(string)
    return true if  @regexp_allowed_mac_address.match(string)
    return true if  @regexp_qos_priority.match(string)
    return true if  can_parse_real?(string)

    false
  end

  def decode(string)
    @data_string_raw = string

# virtual-slot-number/is-IEEE/port-vlan-ID/[additional-vlan-IDs]/[trunk-priority]/is-required[/[virtual-switch][/[MAC-address]/
# [allowed-OS-MAC-addresses]/[QoS-priority]]]

    if can_parse_real?(string)
      parse_real(string)
    elsif match = @regexp_minimum.match(string)

      @virtualSlotNumber	= match[1].to_i
      @isIEEE	= match[2].to_i
      @portVlanID	= match[3].to_i
      @additionalVlanIDs	= match[4]
      @trunkPriority	= match[5].to_i
      @isRequired	= match[6].to_i

    elsif match = @regexp_vswitch.match(string)

      @virtualSlotNumber	= match[1].to_i
      @isIEEE	= match[2].to_i
      @portVlanID	= match[3].to_i
      @additionalVlanIDs	= match[4]
      @trunkPriority	= match[5].to_i
      @isRequired	= match[6].to_i
      @virtualSwitch	= match[7].to_i

    elsif match = @regexp_mac_address.match(string)

      @virtualSlotNumber	= match[1].to_i
      @isIEEE	= match[2].to_i
      @portVlanID	= match[3].to_i
      @additionalVlanIDs	= match[4]
      @trunkPriority	= match[5].to_i
      @isRequired	= match[6].to_i
      @virtualSwitch	= match[7]
      @macAddress	= match[8]

    elsif match = @regexp_allowed_mac_address.match(string)

      @virtualSlotNumber	= match[1].to_i
      @isIEEE	= match[2].to_i
      @portVlanID = match[3].to_i
      @additionalVlanIDs	= match[4]
      @trunkPriority	= match[5].to_i
      @isRequired	= match[6].to_i
      @virtualSwitch = match[7]
      @macAddress	= match[8]
      @allowedOsMacAddresses = match[9]

    elsif match = @regexp_qos_priority.match(string)

      @virtualSlotNumber	= match[1].to_i
      @isIEEE	= match[2].to_i
      @portVlanID	= match[3].to_i
      @additionalVlanIDs	= match[4]
      @trunkPriority	= match[5].to_i
      @isRequired	= match[6].to_i
      @virtualSwitch	= match[7]
      @macAddress	= match[8]
      @allowedOsMacAddresses = match[9]
      @qosPiority	= match[10]

    else
      raise "class:VirtualEthAdapter, function:parse, RegExp couldn't decode string >#{string}<"
    end
  end

  alias parse decode

  def can_parse_real?(string)

    data = HmcString.parse(string)

    data.each_pair do |key, value|
      return false unless @params_real.include?(key.delete("\s"))
    end

    true

  end

  def parse_real(string)

    data = HmcString.parse(string)
    data.each_pair do |key, value|
      case key.delete("\s")
      when 'lpar_name' then @lpar_name = value
      when 'lpar_id' then @lpar_id = value.to_i
      when 'slot_num' then @virtualSlotNumber = value.to_i
      when 'state' then @state = value.to_i
      when 'is_required' then @isRequired = value.to_i
      when 'is_trunk' then @isTrunk = value.to_i
      when 'trunk_priority' then @trunkPriority = value.to_i
      when 'ieee_virtual_eth' then @isIEEE = value.to_i
      when 'port_vlan_id' then @portVlanID = value.to_i
      when 'addl_vlan_ids' then @additionalVlanIDs = value
      when 'mac_addr' then @macAddress = value
      when 'vswitch' then @virtualSwitch = value
      when 'allowed_os_mac_addrs'  then @allowedOsMacAddresses = value
      when 'qos_priority' then @qosPiority = value
      else
        raise Exception, "Can't parse string, wrong key: '#{key}'"
      end
    end
    @_type = 'real'

  end
end