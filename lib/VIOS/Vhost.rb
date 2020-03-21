class Vhost

  #see: https://www.ibm.com/support/knowledgecenter/en/POWER8/p8hcg/p8hcg_lsmap.htm
  attr_accessor :name
  attr_accessor :physloc
  attr_accessor :client_partition_id
  attr_accessor :vtds
  attr_reader :client_partition_id_nice

  attr_accessor :vios
  attr_accessor :sys

  def initialize(string = '', vios = nil, sys = nil)
    @vios = vios
    @sys = sys

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
      raise Exception, "Class:VIOS:Vhost, function: parse, RegExp couldn't decode string >>#{string}<<"
    end
  end

  alias parse decode

  def to_s(fields = 'all', separator = ':')
    # list of possible fields taken from: https://www.ibm.com/support/knowledgecenter/TI0003M/p8hcg/p8hcg_lsmap.htm
    fields_possible = %w[svsa physloc mirrored clientid vtd lun backing bdphysloc status]
    fields = fields.split(separator) unless fields == 'all'

    string = ''
    string += @name + separator if fields == 'all' or fields.include?('svsa')

    data = []
    @vtds.each do |vtd|
      data.push(vtd.to_s(fields, separator))
    end

    string + data.join(separator)
  end

  def to_s_long
    string = "SVSA Physloc Client Partition ID\n"
    string += "------------- --------------------------------- ------------------\n"
    string += @name + ' ' + @physloc + ' ' + @client_partition_id + "\n"
    string += "\n"

    if @vtds.empty?
      string += 'NO VIRTUAL TARGET DEVICE FOUND'
    else
      strings = []
      @vtds.each do |vtd|
        strings.push(vtd.to_s_long)
      end
      string += strings.join("\n")
    end

    string
  end

  def to_s_long_fixed
    string  = "SVSA                 Physloc                           Client Partition ID\n"
    string += "-------------        --------------------------------- ------------------\n"
    string += "#{@name}               #{@physloc}           #{@client_partition_id}\n"
    string += "\n"

    if @vtds.empty?
      string += 'NO VIRTUAL TARGET DEVICE FOUND'
    else
      strings = []
      @vtds.each do |vtd|
        strings.push(vtd.to_s_long_fixed)
      end
      string += strings.join("\n")
    end

    string
  end

end