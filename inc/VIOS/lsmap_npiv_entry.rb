class Lsmap_npiv_entry

  attr_reader :data
  attr_reader :data_string_raw

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


  def initialize(string)

    @data = Hash.new
    @data_string_raw=''

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


    if string.length > 0
      @data_string_raw = string
      self.parse(string)
    end
  end

  def parse(string)

    regexp = %r{^\s*Name\s+Physloc\s+ClntID\s+ClntName\s+ClntOS\s+
.*\s*
(vfchost\d+)\s+(\w{5}\.\w{3}.\w{7}-V\d+-C\d+)\s+(\d+)\s+([\w\w_\-]+|)\s+(AIX|)\s*
Status:(LOGGED_IN|NOT_LOGGED_IN)\s+
FC\sname:(fcs\d+|)\s+FC\s+loc\s+code:(\w{5}\.\w{3}\.\w{7}\-P\d+\-C\d+\-T\d+|)\s+
Ports\slogged\sin:(\d+)\s+
Flags:(a<LOGGED_IN,STRIP_MERGE>|1<NOT_MAPPED,NOT_CONNECTED>)\s+
VFC\s+client\s+name:(fcs\d+|)\s+VFC\s+client\s+DRC:(\w{5}\.\w{3}\.\w{7}\-V\d+-C\d+|\w{5}\.\w{3}\.\w{7}\-V\d+-C\d+\-T\d+|)\s*$
}mx

    match        = regexp.match(string)

    if match
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

end