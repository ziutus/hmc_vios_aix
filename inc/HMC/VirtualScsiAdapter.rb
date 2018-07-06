require 'HMC/virtual_adapter'

class VirtualScsiAdapter < VirtualAdapter

  # TODO: analyze if in case that remote lpar or slot is 'any' can we do simpler code (not so many if..elsif...)
  attr_accessor :clientOrServer
  attr_accessor :remoteLparID
  attr_accessor :remoteLparName
  attr_accessor :remoteSlotNumber

  def initialize(string = '')

    super(string)
    @clientOrServer = nil
    @remoteLparID = nil
    @remoteLparName = nil
    @remoteSlotNumber = nil

    @params = %w[virtualSlotNumber clientOrServer remoteLparID remoteLparName remoteSlotNumber isRequired lpar_name lpar_id]

    @regExp      = %r{^\s*(\d+)/(server|client)/(\d+)/([\w\-\.]+|)/(\d+)/([01])\s*$}
    @regExp_any  = %r{^\s*(\d+)/(server|client)/(any)/([\w\-\.]+|)/(any)/([01])\s*$}
    @regExp_long = %r{^\s*slot_num=(\d+),state=([01]),is_required=([01]),adapter_type=(client|server),remote_lpar_id=(\d+|any),remote_lpar_name=([\w\-]+|),remote_slot_num=(\d+|any)\s*$}
    @regExp_real = %r{^\s*lpar_name=([\w\-]+),lpar_id=(\d+),slot_num=(\d+),state=([01]),is_required=([01]),adapter_type=(client|server),remote_lpar_id=(\d+|any),remote_lpar_name=([\w\-]+|),remote_slot_num=(\d+|any)\s*$}

    parse(string) unless string.empty?
  end

  # virtual-slot-number/client-or-server/[remote-lpar-ID]/[remote-lpar-name]/[remote-slot-number]/is-required
  def to_s
    validate
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
    raise 'remoteLparID is not number or "any"' unless @remoteLparID.is_a? Numeric or @remoteLparID == 'any'

    raise 'remoteLparName not defined' if @remoteLparName.nil?
    raise 'remoteLparName is not string'	unless @remoteLparName.is_a? String

    raise 'remoteSlotNumber not defined' 	if @remoteSlotNumber.nil?
    raise 'remoteSlotNumber is not number or "any"' 	unless @remoteSlotNumber.is_a? Numeric or @remoteSlotNumber == "any"

    raise 'isRequired not defined' 			if @isRequired.nil?
    raise 'isRequired is not number'		unless @isRequired.is_a? Numeric
    raise "isRequired has wrong value #{@isRequired} " unless @isRequired == 0 or @isRequired == 1
  end

  def can_parse?(string)
    return true if  @regExp.match(string) or @regExp_any.match(string) or @regExp_long.match(string) or @regExp_real.match(string)

    false
  end

  def decode(string)
    @data_string_raw = string

    if  match = @regExp.match(string)
      @virtualSlotNumber	= match[1].to_i
      @clientOrServer		= match[2]
      @remoteLparID		= match[3].to_i
      @remoteLparName		= match[4]
      @remoteSlotNumber	= match[5].to_i
      @isRequired			= match[6].to_i
    elsif  match = @regExp_any.match(string)
      @virtualSlotNumber	= match[1].to_i
      @clientOrServer		= match[2]
      @remoteLparID		= match[3]
      @remoteLparName		= match[4]
      @remoteSlotNumber	= match[5]
      @isRequired			= match[6].to_i
    elsif match = @regExp_long.match(string)
      @virtualSlotNumber	= match[1].to_i
      @state				= match[2].to_i
      @isRequired			= match[3].to_i
      @clientOrServer		= match[4]
      @remoteLparID		= match[5].to_i
      @remoteLparName		= match[6]
      @remoteSlotNumber	= match[7].to_i
    elsif match = @regExp_real.match(string)

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
      raise Exception, "Class VirtualScsiAdapter:RegExp couldn't decode string #{string}"
    end
  end

  alias parse decode
end