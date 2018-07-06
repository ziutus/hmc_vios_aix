require 'HMC/virtual_adapter'

class VirtualFCAdapter < VirtualAdapter

  # see: http://www-01.ibm.com/support/docview.wss?uid=nas8N1011009
  # see: https://www.ibm.com/support/knowledgecenter/en/POWER8/p8edm/mksyscfg.html

  attr_accessor :clientOrServer
  attr_accessor :remoteLparID
  attr_accessor :remoteLparName
  attr_accessor :remoteSlotNumber
  attr_accessor :wwpn1
  attr_accessor :wwpn2

  # below data can be taken only from lshwres, they are exist only for running lpars
  attr_accessor :connectStatus


  def initialize(string = '')

    super(string)

    @clientOrServer = nil
    @remoteLparID = nil
    @remoteLparName = nil
    @remoteSlotNumber = nil
    @wwpn1 = nil
    @wwpn2 = nil

    @reg_exp = %r{^\s*["]{0,2}(\d+)/(server|client)/(\d+)/([\w\-]+|)/(\d+)/(\w{16},\w{16}|\w{16}|)/([01])["]{0,2}\s*$}

    @params = %w[virtualSlotNumber isRequired clientOrServer remoteLparID remoteLparName remoteSlotNumber wwpn1 wwpn2]

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
    return true if @reg_exp.match(string)
    false
  end

  def decode(string)
    @data_string_raw = string


    match = @reg_exp.match(string)
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

end