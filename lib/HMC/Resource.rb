require 'pp'

class Resource

  attr_reader :type
  attr_reader :lpar
  attr_reader :frame
  attr_reader :type_long

  # cec:root/ibmhscS1_0|9131-52A*6535CCG|IBMHSC_ComputerSystem,
  # lpar:root/ibmhscS1_0|ALL_PARTITIONS*9131-52A*6535CCG|IBMHSC_Partition
  # lpar:root/ibmhscS1_0|1*9131-52A*6535CCG|IBMHSC_Partition,
  # lpar:root/ibmhscS1_0|5*9131-52A*6535CCG|IBMHSC_Partition
  def initialize(string = '')
    decode(string) unless string.empty?
  end

  def decode(string)

    type_regexp = '\w{4}\-\w{3}\*\w{7}'

    if match = %r{lpar:root[\/]+ibmhscS1_0\|(\d+|ALL_PARTITIONS)\*(#{type_regexp})}.match(string)
      @type_long = 'IBMHSC_Partition'
      @type	= 'lpar'
      @lpar	= match[1]
      @frame = match[2]
    elsif match = %r{cec:root[\/]+ibmhscS1_0\|(#{type_regexp})\|IBMHSC_ComputerSystem}.match(string)
      @type_long =  'IBMHSC_ComputerSystem'
      @type	= 'cec'
      @frame = match[1]
    elsif match = %r{frame:root[\/]+ibmhscS1_0\|(#{type_regexp})\|IBMHSC_Frame}.match(string)
      @type_long = 'IBMHSC_Frame'
      @type	= 'frame'
      @frame = match[1]
    else
      raise Exception, "Regexo couldn't decode string >#{string}<"
    end

  end

end