class Lsmap_npiv_entry

  attr_reader :data
  attr_reader :data_string_raw

  attr_accessor :vios
  attr_accessor :sys

  attr_reader :name
  attr_reader :physloc
  attr_reader :clntid
  attr_reader :clntname
  attr_reader :clntos
  attr_reader :status
  attr_reader :fc_name
  attr_reader :fc_loc_code
  attr_reader :ports_logged_in
  attr_reader :flags
  attr_reader :vfc_client_name
  attr_reader :vfc_client_drc

  def initialize(string, vios = nil, sys = nil)

    @data = {}
    @data_string_raw = ''

    @vios = vios
    @sys = sys

    @name = nil
    @physloc = nil
    @clntid = nil
    @clntname = nil
    @clntos = nil
    @status = nil
    @fc_name = nil
    @fc_loc_code = nil
    @ports_logged_in = nil
    @flags = nil
    @vfc_client_name = nil
    @vfc_client_drc = nil

    unless string.empty?
      @data_string_raw = string
      parse(string)
    end
  end

  def parse(string)

    r_status = 'LOGGED_IN|NOT_LOGGED_IN'
    r_flags = 'a<LOGGED_IN,STRIP_MERGE>|1<NOT_MAPPED,NOT_CONNECTED>|4<NOT_LOGGED>|0<>'
    r_client_drc  = '\w{5}\.\w{3}\.[\w#]{7}\-V\d+\-C\d+|\w{5}\.\w{3}\.[\w#]{7}\-V\d+\-C\d+\-T\d+|'
    r_physloc     = '\w{5}\.\w{3}\.[\w#]{7}\-V\d+\-C\d+'
    r_fc_loc_code = '\w{5}\.\w{3}\.[\w#]{7}\-P\d+\-C\d+\-T\d+|\w{5}\.\w{3}\.[\w#]{7}\-P\d+\-C\d+\-C\d+\-T\d+|'
    r_lparname = '[\w\w_\-]+|'

    regexp = %r{^\s*Name\s+Physloc\s+ClntID\s+ClntName\s+ClntOS\s+
.*\s*
(vfchost\d+)\s+(#{r_physloc})\s+(\d+)\s+(#{r_lparname})\s+(AIX|)\s*
Status:(#{r_status})\s+
FC\sname:(fcs\d+|)\s+FC\s+loc\s+code:(#{r_fc_loc_code})\s+
Ports\slogged\sin:(\d+)\s+
Flags:(#{r_flags})\s+
VFC\s+client\s+name:(fcs\d+|)\s+VFC\s+client\s+DRC:(#{r_client_drc})\s*$
}mx

    regexp_fmt = /(vfchost\d+):(#{r_physloc}):(\d+):(#{r_lparname}):(AIX|):(#{r_status}):(fcs\d+):(#{r_fc_loc_code}):(\d+):(\w+):(fcs\d+):(#{r_client_drc})/

    if match = regexp_fmt.match(string)
      @name            = match[1]
      @physloc         = match[2]
      @clntid          = match[3].to_i
      @clntname        = match[4]
      @clntos          = match[5]
      @status          = match[6]
      @fc_name         = match[7]
      @fc_loc_code     = match[8]
      @ports_logged_in = match[9].to_i
      @flags           = match[10]
      @vfc_client_name = match[11]
      @vfc_client_drc  = match[12]

    elsif match = regexp.match(string)
      @name            = match[1]
      @physloc         = match[2]
      @clntid          = match[3].to_i
      @clntname        = match[4]
      @clntos          = match[5]
      @status          = match[6]
      @fc_name         = match[7]
      @fc_loc_code     = match[8]
      @ports_logged_in = match[9].to_i
      @flags           = match[10]
      @vfc_client_name = match[11]
      @vfc_client_drc  = match[12]

    else
      raise Exception, "Wrong string >#{string}<"
    end

  end

  def to_s(separator = ':')
    "#{@name}#{separator}#{@physloc}#{separator}#{@clntid}#{separator}#{@clntname}#{separator}#{@clntos}" +
    "#{separator}#{@status}#{separator}#{fc_name}#{separator}#{@fc_loc_code}#{separator}#{@ports_logged_in}" +
    "#{separator}#{@flags}#{separator}#{@vfc_client_name}#{separator}#{@vfc_client_drc}"
  end

end