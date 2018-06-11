require 'HMC/virtual_adapter'

class VirtualSerialAdapter < VirtualAdapter

  attr_accessor :clientOrServer
  attr_accessor :supportsHMC
  attr_accessor :remoteLparID
  attr_accessor :remoteLparName
  attr_accessor :remoteSlotNumber

  # below data can be taken only from lshwres, they are exist only for running lpars
  attr_accessor :connectStatus

  def initialize(string='')
    super(string)

    @clientOrServer = nil
    @supportsHMC = nil
    @remoteLparID = nil
    @remoteLparName = nil
    @remoteSlotNumber = nil
    @connectStatus = nil
    @_type = 'profile'

    @params = %w[clientOrServer supportsHMC remoteLparID remoteLparName remoteSlotNumber isRequired]

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



end