class VirtualScsiAdapter

  # TODO: analyze if in case that remote lpar or slot is 'any' can we do simpler code (not so many if..elsif...)

  attr_accessor :virtualSlotNumber
  attr_accessor :clientOrServer
  attr_accessor :remoteLparID
  attr_accessor :remoteLparName
  attr_accessor :remoteSlotNumber
  attr_accessor :isRequired

  attr_accessor :lpar_name
  attr_accessor :lpar_id
  attr_accessor :state
  attr_reader :_type


  def initialize string=''
    @virtualSlotNumber = nil
    @clientOrServer = nil
    @remoteLparID = nil
    @remoteLparName = nil
    @remoteSlotNumber = nil
    @isRequired = nil
    @lpar_name = nil
    @lpar_id = nil

    @_type = 'profile'

    parse(string) unless string.empty?
  end

  #virtual-slot-number/client-or-server/[remote-lpar-ID]/[remote-lpar-name]/[remote-slot-number]/is-required
  def to_s
    self.validate
    if @_type == 'real'
      "lpar_name=#{@lpar_name},lpar_id=#{@lpar_id},slot_num=#{@virtualSlotNumber},state=#{@state},is_required=#{@isRequired},adapter_type=#{@clientOrServer},remote_lpar_id=#{@remoteLparID},remote_lpar_name=#{@remoteLparName},remote_slot_num=#{@remoteSlotNumber}"
    else
      "#{@virtualSlotNumber}/#{@clientOrServer}/#{@remoteLparID}/#{@remoteLparName}/#{@remoteSlotNumber}/#{@isRequired}"
    end
  end

  def validate

    raise 'virtualSlotNumber not defined'	if @virtualSlotNumber == nil
    raise 'virtualSlotNumber is not number' 	unless @virtualSlotNumber.is_a? Numeric
    raise "virtualSlotNumber has wrong value: #{@virtualSlotNumber}" 	if @virtualSlotNumber < 1

    raise 'clinetOrServer not defined' if @clientOrServer.nil?
    clientOrServer_allowed = %w[ client server ]
    raise "clientOrServer has wrong value #{@clientOrServer}" unless clientOrServer_allowed.include?(@clientOrServer)

    raise 'remoteLparID not defined' if @remoteLparID.nil?
    raise 'remoteLparID is not number or "any"' unless (@remoteLparID.is_a? Numeric or @remoteLparID == 'any')

    raise 'remoteLparName not defined' if @remoteLparName.nil?
    raise 'remoteLparName is not string'	unless @remoteLparName.is_a? String

    raise 'remoteSlotNumber not defined' 	if @remoteSlotNumber.nil?
    raise 'remoteSlotNumber is not number or "any"' 	unless (@remoteSlotNumber.is_a? Numeric or @remoteSlotNumber == "any")

    raise 'isRequired not defined' 			if @isRequired.nil?
    raise 'isRequired is not number'		unless @isRequired.is_a? Numeric
    raise "isRequired has wrong value #{@isRequired} " unless (@isRequired == 0 or @isRequired == 1)
  end

  def can_parse?(string)

    regExp      = %r{^\s*(\d+)/(server|client)/(\d+)/([\w\_\-\.]+|)/(\d+)/(0|1)\s*$}
    regExp_any  = %r{^\s*(\d+)/(server|client)/(any)/([\w\_\-\.]+|)/(any)/(0|1)\s*$}
    regExp_long = %r{^\s*slot_num=(\d+),state=(0|1),is_required=(0|1),adapter_type=(client|server),remote_lpar_id=(\d+|any),remote_lpar_name=([\w\_\-]+|),remote_slot_num=(\d+|any)\s*$}
    regExp_real = %r{^\s*lpar_name=([\w\_\-]+),lpar_id=(\d+),slot_num=(\d+),state=(0|1),is_required=(0|1),adapter_type=(client|server),remote_lpar_id=(\d+|any),remote_lpar_name=([\w\_\-]+|),remote_slot_num=(\d+|any)\s*$}

    return true if  match = regExp.match(string)
    return true if  match = regExp_any.match(string)
    return true if  match = regExp_long.match(string)
    return true if  match = regExp_real.match(string)

    false
  end

  def decode(string)
    @data_string_raw = string

    regExp      = %r{^\s*(\d+)/(server|client)/(\d+)/([\w\_\-\.]+|)/(\d+)/(0|1)\s*$}
    regExp_any  = %r{^\s*(\d+)/(server|client)/(any)/([\w\_\-\.]+|)/(any)/(0|1)\s*$}
    regExp_long = %r{^\s*slot_num=(\d+),state=(0|1),is_required=(0|1),adapter_type=(client|server),remote_lpar_id=(\d+|any),remote_lpar_name=([\w\_\-]+|),remote_slot_num=(\d+|any)\s*$}
    regExp_real = %r{^\s*lpar_name=([\w\_\-]+),lpar_id=(\d+),slot_num=(\d+),state=(0|1),is_required=(0|1),adapter_type=(client|server),remote_lpar_id=(\d+|any),remote_lpar_name=([\w\_\-]+|),remote_slot_num=(\d+|any)\s*$}

    if  match = regExp.match(string)
      @virtualSlotNumber	= match[1].to_i
      @clientOrServer		= match[2]
      @remoteLparID		= match[3].to_i
      @remoteLparName		= match[4]
      @remoteSlotNumber	= match[5].to_i
      @isRequired			= match[6].to_i
    elsif  match = regExp_any.match(string)
      @virtualSlotNumber	= match[1].to_i
      @clientOrServer		= match[2]
      @remoteLparID		= match[3]
      @remoteLparName		= match[4]
      @remoteSlotNumber	= match[5]
      @isRequired			= match[6].to_i
    elsif match = regExp_long.match(string)
      @virtualSlotNumber	= match[1].to_i
      @state				= match[2].to_i
      @isRequired			= match[3].to_i
      @clientOrServer		= match[4]
      @remoteLparID		= match[5].to_i
      @remoteLparName		= match[6]
      @remoteSlotNumber	= match[7].to_i
    elsif match = regExp_real.match(string)

      @lpar_name = match[1]
      @lpar_id = match[2].to_i
      @virtualSlotNumber	= match[3].to_i
      @state = match[4].to_i
      @isRequired	= match[5].to_i
      @clientOrServer	= match[6]
      @remoteLparID	= match[7].to_i
      @remoteLparName	= match[8]
      @remoteSlotNumber	= match[9].to_i
      @_type = 'real'
    else
      abort "Class VirtualScsiAdapter:RegExp couldn't decode string #{string}"
    end
  end

  alias parse decode

  def ==(other)
    to_s == other.to_s
  end

  def diff(other_adapter, profile1, profile2)
    diff = {}

    if @clientOrServer != other_adapter.clientOrServer
      diff_entry = {}
      diff_entry[profile1] = "clientOrServer is setup to #{@clientOrServer}"
      diff_entry[profile2] = "clientOrServer is setup to #{other_adapter.clientOrServer}"
      diff['clientOrServer'] = diff_entry
    end

    if @remoteLparID != other_adapter.remoteLparID
      diff_entry = {}
      diff_entry[profile1] = "remoteLparID is setup to #{@remoteLparID}"
      diff_entry[profile2] = "remoteLparID is setup to #{other_adapter.remoteLparID}"
      diff['remoteLparID'] = diff_entry
    end

    if @remoteLparName != other_adapter.remoteLparName
      diff_entry = {}
      diff_entry[profile1] = "remoteLparName is setup to #{@remoteLparName}"
      diff_entry[profile2] = "remoteLparName is setup to #{other_adapter.remoteLparName}"
      diff['remoteLparName'] = diff_entry
    end

    if @remoteSlotNumber != other_adapter.remoteSlotNumber
      diff_entry = {}
      diff_entry[profile1] = "remoteSlotNumber is setup to #{@remoteSlotNumber}"
      diff_entry[profile2] = "remoteSlotNumber is setup to #{other_adapter.remoteSlotNumber}"
      diff['remoteSlotNumber'] = diff_entry
    end

    if @isRequired != other_adapter.isRequired
      diff_entry = {}
      diff_entry[profile1] = "isRequired is setup to #{@isRequired}"
      diff_entry[profile2] = "isRequired is setup to #{other_adapter.isRequired}"
      diff['isRequired'] = diff_entry
    end

    diff
  end

end