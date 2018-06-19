class Vhost

  #see: https://www.ibm.com/support/knowledgecenter/en/POWER8/p8hcg/p8hcg_lsmap.htm
  attr_accessor :name
  attr_accessor :physloc
  attr_accessor :client_partition_id
  attr_accessor :vtds
  attr_reader :client_partition_id_nice

  def initialize(string = '')
    @vtds = []
    parse(string) unless string.empty?
  end

  def decode(string)
    regexp = %r{^\s*(vhost\d+)\s+([\.\-\w]+)\s+(0x\w+)\s*$}

    if match = regexp.match(string)
      @name = match[1]
      @physloc = match[2]
      @client_partition_id = match[3]
      @client_partition_id_nice = Integer(match[3])
    else
      raise "Class:VIOS:Vhost, function: parse, RegExp couldn't decode string >>#{string}<<"
    end
  end

  alias parse decode
end