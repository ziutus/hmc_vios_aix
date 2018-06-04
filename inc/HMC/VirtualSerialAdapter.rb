class VirtualSerialAdapter

  attr_accessor :virtualSlotNumber
  attr_accessor :clientOrServer
  attr_accessor :supportsHMC
  attr_accessor :remoteLparID
  attr_accessor :remoteLparName
  attr_accessor :remoteSlotNumber
  attr_accessor :isRequired
  # below data can be taken only from lshwres, they are exist only for running lpars
  attr_accessor :lpar_name
  attr_accessor :lpar_id
  attr_accessor :state
  attr_accessor :connectStatus
  # type of input / output (data can be taken from profile or real setup (lshwres...))
  attr_reader :_type

  def initialize(string='')
    @virtualSlotNumber = nil
    @clientOrServer = nil
    @supportsHMC = nil
    @remoteLparID = nil
    @remoteLparName = nil
    @remoteSlotNumber = nil
    @isRequired = nil
    @lpar_name = nil
    @lpar_id = nil
    @state = nil
    @connectStatus = nil
    @_type = 'profile'

    parse(string) unless string.empty?
  end

  def can_parse?(string)
    regexp      = /^\s*(\d+)\/(server|client)\/(0|1)\/(\d+|any)\/([\w\_\-]+|)\/(\d+|any)\/(0|1)\s*$/
    regexp_real = %r{^\s*lpar_name=([\w\_\-]+),lpar_id=(\d+),slot_num=(\d+),state=(0|1),is_required=(0|1),connect_status=(unavailable),adapter_type=(server|client),supports_hmc=(0|1),remote_lpar_id=(\d+|any),remote_lpar_name=([\w\_\-]+|),remote_slot_num=(\d+|any)\s*$}

    return true if  match = regexp.match(string)
    return true if  match = regexp_real.match(string)

    false
  end


  def decode(string)
    @data_string_raw = string

    regexp = /^\s*(\d+)\/(server|client)\/(0|1)\/(\d+|any)\/([\w\_\-]+|)\/(\d+|any)\/(0|1)\s*$/
    regexp_real = %r{^\s*lpar_name=([\w\_\-]+),lpar_id=(\d+),slot_num=(\d+),state=(0|1),is_required=(0|1),connect_status=(unavailable),adapter_type=(server|client),supports_hmc=(0|1),remote_lpar_id=(\d+|any),remote_lpar_name=([\w\_\-]+|),remote_slot_num=(\d+|any)\s*$}

    if match = regexp.match(string)

      @virtualSlotNumber	= match[1].to_i
      @clientOrServer		= match[2]
      @supportsHMC		= match[3].to_i
      @remoteLparID		= match[4]
      @remoteLparName		= match[5]
      @remoteSlotNumber	= match[6]
      @isRequired			= match[7].to_i
    elsif match = regexp_real.match(string)

      @lpar_name = match[1]
      @lpar_id = match[2].to_i
      @virtualSlotNumber	= match[3].to_i
      @state = match[4].to_i
      @isRequired			= match[5].to_i
      @connectStatus = match[6]
      @clientOrServer		= match[7]
      @supportsHMC		= match[8].to_i
      @remoteLparID		= match[9]
      @remoteLparName		= match[10]
      @remoteSlotNumber	= match[11]
      @_type = 'real'

    else
      abort "Class VirtualSerialAdapter: RegExp couldn't decode string #{string}"
    end
  end

  alias parse decode


  #virtual-slot-number/client-or-server/[supports-HMC]/[remote-lpar-ID]/[remote-lpar-name]/[remote-slot-number]/is-required
  def to_s
    "#{@virtualSlotNumber}/#{@clientOrServer}/#{@supportsHMC}/#{@remoteLparID}/#{@remoteLparName}/#{@remoteSlotNumber}/#{@isRequired}"
  end

  def ==(other)
    to_s == other.to_s
  end

  def diff(other_adapter, profile1, profile2)
    diff = []

    #if class.name != other_adapter.class.name
    #  diff.push('different types of adapters')
    #  return diff
    #end

    if @clientOrServer != other_adapter.clientOrServer
      diff_entry = {}
      diff_entry[profile1] = "clientOrServer is setup to #{@clientOrServer}"
      diff_entry[profile2] = "clientOrServer is setup to #{other_adapter.clientOrServer}"
      diff["clientOrServer"] = diff_entry
    end

    if @supportsHMC != other_adapter.supportsHMC
      diff_entry = {}
      diff_entry[profile1] = "supportsHMC is setup to #{@supportsHMC}"
      diff_entry[profile2] = "supportsHMC is setup to #{other_adapter.supportsHMC}"
      diff["supportsHMC"] = diff_entry
    end

    if @remoteLparID != other_adapter.remoteLparID
      diff_entry = {}
      diff_entry[profile1] = "remoteLparID is setup to #{@remoteLparID}"
      diff_entry[profile2] = "remoteLparID is setup to #{other_adapter.remoteLparID}"
      diff["remoteLparID"] = diff_entry
    end

    if @remoteLparName != other_adapter.remoteLparName
      diff_entry = {}
      diff_entry[profile1] = "remoteLparName is setup to #{@remoteLparName}"
      diff_entry[profile2] = "remoteLparName is setup to #{other_adapter.remoteLparName}"
      diff["remoteLparName"] = diff_entry
    end

    if @remoteSlotNumber != other_adapter.remoteSlotNumber
      diff_entry = {}
      diff_entry[profile1] = "remoteSlotNumber is setup to #{@remoteSlotNumber}"
      diff_entry[profile2] = "remoteSlotNumber is setup to #{other_adapter.remoteSlotNumber}"
      diff["remoteSlotNumber"] = diff_entry
    end

    if @isRequired != other_adapter.isRequired
      diff_entry = {}
      diff_entry[profile1] = "isRequired is setup to #{@isRequired}"
      diff_entry[profile2] = "isRequired is setup to #{other_adapter.isRequired}"
      diff["isRequired"] = diff_entry
    end

    diff
  end

end