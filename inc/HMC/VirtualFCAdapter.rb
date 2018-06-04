class VirtualFCAdapter

  # see: http://www-01.ibm.com/support/docview.wss?uid=nas8N1011009
  # see: https://www.ibm.com/support/knowledgecenter/en/POWER8/p8edm/mksyscfg.html

  attr_accessor :virtualSlotNumber
  attr_accessor :clientOrServer
  attr_accessor :remoteLparID
  attr_accessor :remoteLparName
  attr_accessor :remoteSlotNumber
  attr_accessor :wwpn1
  attr_accessor :wwpn2
  attr_accessor :isRequired
  # below data can be taken only from lshwres, they are exist only for running lpars
  attr_accessor :lpar_name
  attr_accessor :lpar_id
  attr_accessor :state
  attr_accessor :connectStatus
  # type of input / output (data can be taken from profile or real setup (lshwres...))
  attr_reader :_type

  def initialize(string = '')
    @virtualSlotNumber = nil
    @clientOrServer = nil
    @remoteLparID = nil
    @remoteLparName = nil
    @remoteSlotNumber = nil
    @wwpn1 = nil
    @wwpn2 = nil
    @isRequired=0

    @_type = ''
    parse(string) unless string.empty?
  end

  def validate
    raise 'virtualSlotNumber not defined' unless @virtualSlotNumber.is_a? Numeric
  end

  def to_s
    validate

    # virtual-slot-number/client-or-server/[remote-lpar-ID]/[remote-lpar-name]/remote-slot-number/[wwpns]/is-required
    result = "#{@virtualSlotNumber}/#{clientOrServer}/#{@remoteLparID}/#{@remoteLparName}/#{@remoteSlotNumber}/"
    result += @wwpn1 unless @wwpn1.nil?
    result += ",#{@wwpn2}" unless @wwpn2.nil?
    result += "/#{@isRequired}"

    result = '""' + result + '""' if result.include?(',')

    result
  end

  def can_parse?(string)
    # TODO: change it to "one liner"
    reg_exp = %r{^\s*[\"]{0,2}(\d+)/(server|client)/(\d+)/([\w\-\_]+|)/(\d+)/(\w{16}\,\w{16}|\w{16}|)/(0|1)[\"]{0,2}\s*$}
    return true if match = reg_exp.match(string)
    false
  end

  def decode(string)
    @data_string_raw = string

    # virtual-slot-number/client-or-server/[remote-lpar-ID]/[remote-lpar-name]/remote-slot-number/[wwpns]/is-required
    regExp = %r{^\s*[\"]{0,2}(\d+)/(server|client)/(\d+)/([\w\-\_]+|)/(\d+)/(\w{16}\,\w{16}|\w{16}|)/(0|1)[\"]{0,2}\s*$}

    match = regExp.match(string)
    raise "RegExp couldn't decode string #{string}" unless match

    @virtualSlotNumber 	= match[1].to_i
    @clientOrServer 	= match[2]
    @remoteLparID 		= match[3].to_i
    @remoteLparName		= match[4]
    @remoteSlotNumber 	= match[5].to_i
    wwpns	= match[6]
    @isRequired	= match[7].to_i

    if match2 = %r{^\s*(\w{16})\,(\w{16})\s*$}.match(wwpns)
      @wwpn1 = match2[1]
      @wwpn2 = match2[2]
    elsif match3 = %r{^\s*(\w{16})\s*$}.match(wwpns)
      @wwpn1 = match3[1]
      @wwpn2 = nil
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

    if @wwpn1 != other_adapter.wwpn1
      diff_entry = {}
      diff_entry[profile1] = "wwpn1 is setup to #{@wwpn1}"
      diff_entry[profile2] = "wwpn1 is setup to #{other_adapter.wwpn1}"
      diff['wwpn1'] = diff_entry
    end

    if @wwpn2 != other_adapter.wwpn2
      diff_entry = {}
      diff_entry[profile1] = "wwpn2 is setup to #{@wwpn2}"
      diff_entry[profile2] = "wwpn2 is setup to #{other_adapter.wwpn2}"
      diff['wwpn2'] = diff_entry
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