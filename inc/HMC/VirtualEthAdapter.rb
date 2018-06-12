require 'HMC/virtual_adapter'

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

    @regexp_minimum 			       = %r{^\s*(\d+)/(0|1)/(\d+)/([\d\,]+|)/(\d+)/(0|1)\s*$}
    @regexp_vswitch 			       = %r{^\s*(\d+)/(0|1)/(\d+)/([\d\,]+|)/(\d+)/(0|1)/([\w\_\-]+)\s*$}
    @regexp_mac_address 		     = %r{^\s*(\d+)/(0|1)/(\d+)/([\d\,]+|)/(\d+)/(0|1)/([\w\_\-]+)/(\w+|)\s*$}
    @regexp_allowed_mac_address = %r{^\s*(\d+)/(0|1)/(\d+)/([\d\,]+|)/(\d+)/(0|1)/([\w\_\-]+)/(\w+|)/([\w\,]+|all)\s*$}
    @regexp_qos_priority 	       = %r{^\s*(\d+)/(0|1)/(\d+)/([\d\,]+|)/(\d+)/(0|1)/([\w\_\-]+)/(\w+|)/([\w\,]+|all)/(\d+|none)\s*$}
    @regexp_real                = %r{^lpar_name=([\w\_\-]+),lpar_id=(\d+),slot_num=(\d+),state=(0|1),is_required=(0|1),is_trunk=(0),ieee_virtual_eth=(0|1),port_vlan_id=(\d+),addl_vlan_ids=(\d+|),mac_addr=(\w{12})$}
    @regexp_real2               = %r{^lpar_name=([\w\_\-]+),lpar_id=(\d+),slot_num=(\d+),state=(0|1),is_required=(0|1),is_trunk=(1),trunk_priority=(\d+),ieee_virtual_eth=(0|1),port_vlan_id=(\d+),addl_vlan_ids=(\d+|),mac_addr=(\w{12})$}

    @params = %w[isIEEE portVlanID additionalVlanIDs trunkPriority isTrunk virtualSwitch macAddress allowedOsMacAddresses qosPiority]

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
    return true if  @regexp_real.match(string)
    return true if  @regexp_real2.match(string)

    false
  end

  def decode(string)
    @data_string_raw = string

# virtual-slot-number/is-IEEE/port-vlan-ID/[additional-vlan-IDs]/[trunk-priority]/is-required[/[virtual-switch][/[MAC-address]/
# [allowed-OS-MAC-addresses]/[QoS-priority]]]

    if match = @regexp_minimum.match(string)

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

    elsif match = @regexp_real.match(string)

      @lpar_name = match[1]
      @lpar_id = match[2].to_i
      @virtualSlotNumber	= match[3].to_i
      @state = match[4].to_i
      @isRequired	= match[5].to_i
      @isTrunk	= match[6].to_i
      @trunkPriority	= match[6].to_i
      @isIEEE	= match[7].to_i
      @portVlanID	= match[8].to_i
      @additionalVlanIDs	= match[9]
      @macAddress	= match[10]
      @_type = 'real'

    elsif match = @regexp_real2.match(string)

      @lpar_name = match[1]
      @lpar_id = match[2].to_i
      @virtualSlotNumber	= match[3].to_i
      @state = match[4].to_i
      @isRequired	= match[5].to_i
      @isTrunk	= match[6].to_i
      @trunkPriority	= match[7].to_i
      @isIEEE	= match[8].to_i
      @portVlanID	= match[9].to_i
      @additionalVlanIDs	= match[10]
      @macAddress	= match[11]
      @_type = 'real'

    else
      raise "class:VirtualEthAdapter, function:parse, RegExp couldn't decode string >#{string}<"
    end
  end

  alias parse decode

end