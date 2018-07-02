class Vtd

  #see: https://www.ibm.com/support/knowledgecenter/en/POWER8/p8hcg/p8hcg_lsmap.htm

  attr_accessor :name
  attr_accessor :status
  attr_accessor :lun
  attr_accessor :backing_device
  attr_accessor :physloc
  attr_accessor :mirrored

  def initialize(string = '')
    @name = nil
    @status = nil
    @lun = nil
    @backing_device = nil
    @physloc = nil
    @mirrored = nil

    parse(string) unless string.empty?
  end

  def decode(string)

    regExp =  %r{^\s*VTD\s+([\w\_\-]+)\s*
Status\s+(Available|Defined)\s+
LUN\s+(0x\w+)\s+
Backing\sdevice\s+([\w\-\_\.]+)\s+
Physloc\s+([\w\.\-]+)\s+
Mirrored\s+(false|true)\s*$}mx

    regExp2 =  %r{^\s*VTD\s+([\w\_\-]+)\s*
Status\s+(Available|Defined)\s+
LUN\s+(0x\w+)\s+
Backing\sdevice\s+([\w\-\_\.]+)\s+
Physloc\s*$}mx

    regExp3 =  %r{^\s*VTD\s+([\w\_\-]+)\s*
LUN\s+(0x\w+)\s+
Backing\sdevice\s+([\w\-\_\.]+)\s+
Physloc\s*$}mx

    regExp4 =  %r{^\s*VTD\s+([\w\_\-]+)\s*
Status\s+(Available|Defined)\s+
LUN\s+(0x\w+)\s+
Backing\sdevice\s+([\w\-\_\.]+)\s+
Physloc\s+([\w\.\-]+)\s*$}mx

    if match = regExp.match(string)

      @name 			= match[1]
      @status 		= match[2]
      @lun 			  = match[3]
      @backing_device = match[4]
      @physloc		= match[5]
      @mirrored 	= match[6]

    elsif match = regExp2.match(string)

      @name 			= match[1]
      @status 		= match[2]
      @lun 			  = match[3]
      @backing_device = match[4]
      @physloc		= match[5].to_s

    elsif match = regExp3.match(string)

      @name 			= match[1]
      @lun 			  = match[2]
      @backing_device = match[3]
      @physloc		= match[4].to_s

    elsif match = regExp4.match(string)

      @name 			= match[1]
      @status 		= match[2]
      @lun 			  = match[3]
      @backing_device = match[4]
      @physloc		= match[5].to_s

    else
      raise "VIOS->Vtd: parse: RegExp couldn't decode string >>#{string}<<"
    end
  end

  alias parse decode
end