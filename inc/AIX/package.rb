require 'pp'


class Package

  attr_accessor :fileset
  attr_accessor :level
  attr_accessor :state
  attr_accessor :type
  attr_accessor :description

  def initialize(string)

    parse(string) unless string.empty?
  end


  def parse(string)

    # 'bos:bos.rte.security:5.3.1.1 : : :C:F:Base Security Function: : : : : : :0:1:/:1806'
    # ([\w\s]+):( ):( ):( ):( ):( ):( ):(\d):(\d):\/:(\d+)$
    regexp_lslpp_qcL= /^(\w+):([\w\.]+):([\d\.]+):(\s):(\s):(\w):(\w):([\w\s]+):/

    if match = regexp_lslpp_qcL.match(string)

      @fileset = match[2]
      @level = match[3]
      @description = match[8]

    else
      raise Exception, "can't parse string >#{string}"
    end

 end


end