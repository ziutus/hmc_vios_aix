class Vtd

  #see: https://www.ibm.com/support/knowledgecenter/en/POWER8/p8hcg/p8hcg_lsmap.htm

  # list of possible fields taken from: https://www.ibm.com/support/knowledgecenter/TI0003M/p8hcg/p8hcg_lsmap.htm
  # fields_possible = %w[svsa physloc mirrored clientid vtd lun backing bdphysloc status]


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

  # list of possible fields taken from: https://www.ibm.com/support/knowledgecenter/TI0003M/p8hcg/p8hcg_lsmap.htm
  # fields_possible = %w[svsa physloc mirrored clientid vtd lun backing bdphysloc status]

  def to_s(fields = 'all', separator = ':')
    result = []
#    fields = "physloc:mirrored:vtd:lun:backing:bdphysloc:status" if fields == 'all'
    fields = "physloc:mirrored:lun:backing:status" if fields == 'all'
    fields = fields.split(separator) unless fields.kind_of?(Array)

    fields.each do |field|
      case field
      when 'physloc' then result.push(@physloc)
      when 'mirrored' then result.push(@mirrored)
      when 'lun' then result.push(@lun)
      when 'backing' then result.push(@backing_device)
      #when 'bdphysloc' then result.push(@)
      when 'status' then result.push(@status)
      when 'vtd' then result.push(@name)
      when 'svsa' then next
      else
        raise Exception, "Unknown field #{field}"
      end
    end

    result.join(separator)
  end

  def to_s_long(spaces = 1)
    string = "VTD#{make_spaces(1)}#{@name}"
    string += "\nStatus#{make_spaces(1)}#{@status}" unless @status.nil?
    string += "\nLUN#{make_spaces(1)}#{@lun}" unless @lun.nil?
    string += "\nBacking device#{make_spaces(1)}#{@backing_device}" unless @backing_device.nil?

    string += if @physloc.empty?
                "\nPhysloc\n"
              else
                "\nPhysloc#{make_spaces(1)}#{@physloc}\n"
              end
    string += "Mirrored#{make_spaces(1)}#{@mirrored}\n" unless @mirrored.nil?

    string
  end

  def to_s_long_fixed(spaces = 8)
    string    = "VTD           #{make_spaces(spaces)}#{@name}"
    string += "\nStatus        #{make_spaces(spaces)}#{@status}" unless @status.nil?
    string += "\nLUN           #{make_spaces(spaces)}#{@lun}" unless @lun.nil?
    string += "\nBacking device#{make_spaces(spaces)}#{@backing_device}" unless @backing_device.nil?

    string += if @physloc.nil? || @physloc.empty?
                "\nPhysloc\n"
              else
                "\nPhysloc       #{make_spaces(spaces)}#{@physloc}\n"
              end
    string += "Mirrored      #{make_spaces(spaces)}#{@mirrored}\n" unless @mirrored.nil?

    string
  end


  def make_spaces(spaces = 1)
    string = ''
    1.step(spaces) { |i| string += ' ' }
    string
  end
end