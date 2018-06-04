class VirtualEthAdapter

  attr_accessor :virtualSlotNumber
  attr_accessor :isIEEE
  attr_accessor :portVlanID
  attr_accessor :additionalVlanIDs
  attr_accessor :trunkPriority
  attr_accessor :isTrunk
  attr_accessor :isRequired
  attr_accessor :virtualSwitch
  attr_accessor :macAddress
  attr_accessor :allowedOsMacAddresses
  attr_accessor :qosPiority

  def initialize string=''
    @virtualSlotNumber = nil
    @isIEEE = 0
    @portVlanID = nil
    @additionalVlanIDs = ''
    @isTrunk = 0
    @trunkPriority = 0 #if trunk is true, trunk priority has to to be set up
    @isRequired = 0

    @virtualSwitch = nil

    @macAddress = nil
    @allowedOsMacAddresses = nil
    @qosPiority = nil

    if string.length > 0
      self.parse(string)
    end
  end


  def validate
    raise 'class: VirtualEthAdapter: function: validation, virtualSlotNumber not defined' unless (@virtualSlotNumber.is_a? Numeric)
    raise 'class: VirtualEthAdapter: function: validation, isIEEE not defined' unless (@isIEEE.is_a? Numeric)
    raise 'class: VirtualEthAdapter: function: validation, isRequired not defined' unless (@isRequired.is_a? Numeric)
  end

  def to_s

    validate

    result = "#{@virtualSlotNumber}/#{@isIEEE}/#{@portVlanID}/#{@additionalVlanIDs}/#{@trunkPriority}/#{@isRequired}"
    result += "/#{@virtualSwitch}" unless @virtualSwitch.nil?
    result += "/#{@macAddress}" unless @macAddress.nil?
    result += "/#{@allowedOsMacAddresses}" unless @allowedOsMacAddresses.nil?
    result += "/#{@qosPiority}" unless @qosPiority.nil?

    result = '""' + result + '""' if result.include?(',')

    result
  end

  def can_parse?(string)

    regexp_minimum 			         = %r{^\s*(\d+)/(0|1)/(\d+)/([\d\,]+|)/(\d+)/(0|1)\s*$}
    regexp_vswitch 			         = %r{^\s*(\d+)/(0|1)/(\d+)/([\d\,]+|)/(\d+)/(0|1)/([\w\_\-]+)\s*$}
    regexp_mac_address 		       = %r{^\s*(\d+)/(0|1)/(\d+)/([\d\,]+|)/(\d+)/(0|1)/([\w\_\-]+)/(\w+|)\s*$}
    regexp_allowed_mac_address  = %r{^\s*(\d+)/(0|1)/(\d+)/([\d\,]+|)/(\d+)/(0|1)/([\w\_\-]+)/(\w+|)/([\w\,]+|all)\s*$}
    regexp_qos_priority 	       = %r{^\s*(\d+)/(0|1)/(\d+)/([\d\,]+|)/(\d+)/(0|1)/([\w\_\-]+)/(\w+|)/([\w\,]+|all)/(\d+|none)\s*$}

    return true if  match = regexp_minimum
    return true if  match = regexp_vswitch
    return true if  match = regexp_mac_address
    return true if  match = regexp_allowed_mac_address
    return true if  match = regexp_qos_priority

    false
  end

  def decode(string)
    @data_string_raw = string

# virtual-slot-number/is-IEEE/port-vlan-ID/[additional-vlan-IDs]/[trunk-priority]/is-required[/[virtual-switch][/[MAC-address]/
# [allowed-OS-MAC-addresses]/[QoS-priority]]]

    regexp_minimum 			         = %r{^\s*(\d+)/(0|1)/(\d+)/([\d\,]+|)/(\d+)/(0|1)\s*$}
    regexp_vswitch 			         = %r{^\s*(\d+)/(0|1)/(\d+)/([\d\,]+|)/(\d+)/(0|1)/([\w\_\-]+)\s*$}
    regexp_mac_address 		       = %r{^\s*(\d+)/(0|1)/(\d+)/([\d\,]+|)/(\d+)/(0|1)/([\w\_\-]+)/(\w+|)\s*$}
    regexp_allowed_mac_address  = %r{^\s*(\d+)/(0|1)/(\d+)/([\d\,]+|)/(\d+)/(0|1)/([\w\_\-]+)/(\w+|)/([\w\,]+|all)\s*$}
    regexp_qos_priority 	       = %r{^\s*(\d+)/(0|1)/(\d+)/([\d\,]+|)/(\d+)/(0|1)/([\w\_\-]+)/(\w+|)/([\w\,]+|all)/(\d+|none)\s*$}

    if match = regexp_minimum.match(string)

      @virtualSlotNumber	= match[1].to_i
      @isIEEE	= match[2].to_i
      @portVlanID	= match[3].to_i
      @additionalVlanIDs	= match[4]
      @trunkPriority	= match[5].to_i
      @isRequired	= match[6].to_i

    elsif match = regexp_vswitch.match(string)

      @virtualSlotNumber	= match[1].to_i
      @isIEEE	= match[2].to_i
      @portVlanID	= match[3].to_i
      @additionalVlanIDs	= match[4]
      @trunkPriority	= match[5].to_i
      @isRequired	= match[6].to_i
      @virtualSwitch	= match[7].to_i

    elsif match = regexp_mac_address.match(string)

      @virtualSlotNumber	= match[1].to_i
      @isIEEE	= match[2].to_i
      @portVlanID	= match[3].to_i
      @additionalVlanIDs	= match[4]
      @trunkPriority	= match[5].to_i
      @isRequired	= match[6].to_i
      @virtualSwitch	= match[7]
      @macAddress	= match[8]

    elsif match = regexp_allowed_mac_address.match(string)

      @virtualSlotNumber	= match[1].to_i
      @isIEEE	= match[2].to_i
      @portVlanID = match[3].to_i
      @additionalVlanIDs	= match[4]
      @trunkPriority	= match[5].to_i
      @isRequired	= match[6].to_i
      @virtualSwitch = match[7]
      @macAddress	= match[8]
      @allowedOsMacAddresses = match[9]

    elsif match = regexp_qos_priority.match(string)

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

  def ==(other)
    to_s == other.to_s
  end

  def diff(other_adapter, profile1, profile2)
    diff = {}

    if @isIEEE != other_adapter.isIEEE
      diff_entry = {}
      diff_entry[profile1] = "isIEEE is setup to #{@isIEEE}"
      diff_entry[profile2] = "isIEEE is setup to #{other_adapter.isIEEE}"
      diff['isIEEE'] = diff_entry
    end

    if @portVlanID != other_adapter.portVlanID
      diff_entry = {}
      diff_entry[profile1] = "portVlanID is setup to #{@portVlanID}"
      diff_entry[profile2] = "portVlanID is setup to #{other_adapter.portVlanID}"
      diff['portVlanID'] = diff_entry
    end

    if @additionalVlanIDs != other_adapter.additionalVlanIDs
      diff_entry = {}
      diff_entry[profile1] = "additionalVlanIDs is setup to #{@additionalVlanIDs}"
      diff_entry[profile2] = "additionalVlanIDs is setup to #{other_adapter.additionalVlanIDs}"
      diff['additionalVlanIDs'] = diff_entry
    end

    if @trunkPriority != other_adapter.trunkPriority
      diff_entry = {}
      diff_entry[profile1] = "trunkPriority is setup to #{@trunkPriority}"
      diff_entry[profile2] = "trunkPriority is setup to #{other_adapter.trunkPriority}"
      diff['trunkPriority'] = diff_entry
    end

    if @isTrunk != other_adapter.isTrunk
      diff_entry = {}
      diff_entry[profile1] = "isTrunk is setup to #{@isTrunk}"
      diff_entry[profile2] = "isTrunk is setup to #{other_adapter.isTrunk}"
      diff['trunkPriority'] = diff_entry
    end

    if @isRequired != other_adapter.isRequired
      diff_entry = {}
      diff_entry[profile1] = "isRequired is setup to #{@isRequired}"
      diff_entry[profile2] = "isRequired is setup to #{other_adapter.isRequired}"
      diff['isRequired'] = diff_entry
    end

    if @virtualSwitch != other_adapter.virtualSwitch
      diff_entry = {}
      diff_entry[profile1] = "virtualSwitch is setup to #{@virtualSwitch}"
      diff_entry[profile2] = "virtualSwitch is setup to #{other_adapter.virtualSwitch}"
      diff['virtualSwitch'] = diff_entry
    end

    if @macAddress != other_adapter.macAddress
      diff_entry = {}
      diff_entry[profile1] = "macAddress is setup to #{@macAddress}"
      diff_entry[profile2] = "macAddress is setup to #{other_adapter.macAddress}"
      diff['macAddress'] = diff_entry
    end

    if @allowedOsMacAddresses != other_adapter.allowedOsMacAddresses
      diff_entry = {}
      diff_entry[profile1] = "allowedOsMacAddresses is setup to #{@allowedOsMacAddresses}"
      diff_entry[profile2] = "allowedOsMacAddresses is setup to #{other_adapter.allowedOsMacAddresses}"
      diff['macAddress'] = diff_entry
    end

    if @qosPiority != other_adapter.qosPiority
      diff_entry = {}
      diff_entry[profile1] = "qosPiority is setup to #{@qosPiority}"
      diff_entry[profile2] = "qosPiority is setup to #{other_adapter.qosPiority}"
      diff['qosPiority'] = diff_entry
    end

    diff
  end
end