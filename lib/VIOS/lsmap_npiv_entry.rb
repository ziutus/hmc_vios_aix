require 'AIX/location_code'

class Lsmap_npiv_entry

  attr_reader :data
  attr_reader :data_string_raw

  attr_accessor :vios
  attr_accessor :sys

  attr_accessor :fabric

  attr_accessor :name
  attr_accessor :physloc
  attr_accessor :clntid
  attr_accessor :clntname
  attr_accessor :clntos
  attr_accessor :status
  attr_accessor :fc_name
  attr_accessor :fc_loc_code
  attr_accessor :ports_logged_in
  attr_reader :flags
  attr_reader :flags_short
  attr_accessor :vfc_client_name
  attr_accessor :vfc_client_drc

  attr_accessor :errors
  attr_accessor :warnings

  def initialize(string = nil, vios = nil, sys = nil)

    @data_string_raw = ''

    @errors = []
    @warnings = []

    @vios = vios
    @sys = sys

    @fabric = nil

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

    @r_status = 'LOGGED_IN|NOT_LOGGED_IN'
    @r_flags = 'a<LOGGED_IN,STRIP_MERGE>|1<NOT_MAPPED,NOT_CONNECTED>|4<NOT_LOGGED>|0<>'
    @r_lparname = '[\w\w_\-]+|'

    @_flags_short = { 'a' => 'a<LOGGED_IN,STRIP_MERGE>', '1' => '1<NOT_MAPPED,NOT_CONNECTED>', '4' => '4<NOT_LOGGED>', '0' => '0<>'}
    @_flags       = { 'a<LOGGED_IN,STRIP_MERGE>' => 'a', '1<NOT_MAPPED,NOT_CONNECTED>' => '1', '4<NOT_LOGGED>' => '4', '0<>' => '0'}


    parse(string) unless string.nil? || string.empty?
  end

  def flags=(string)
    @flags = string
    if @_flags.has_key?(string)
      @flags_short = @_flags[string]
    else
      raise Exception, "Wrong string >#{string}"
    end
  end

  def flags_short=(string)
    @flags_short = string
    if @_flags_short.has_key?(string)
      @flags = @_flags_short[string]
    else
      raise Exception, "Wrong string >#{string}<"
    end

  end

  def parse(string)
    @data_string_raw = string

    r_client_drc  = LocationCode.regexp_string('virtual_planar_client') + '|'
    r_fc_loc_code = LocationCode.regexp_string('physical_planar') + '|'
    r_physloc     = LocationCode.regexp_string('virtual_planar')



    regexp = %r{^\s*Name\s+Physloc\s+ClntID\s+ClntName\s+ClntOS\s+
.*\s*
(vfchost\d+)\s+(#{r_physloc})\s+(\d+)\s+(#{@r_lparname})\s+(AIX|)\s*
Status:(#{@r_status})\s+
FC\sname:(fcs\d+|)\s+FC\s+loc\s+code:(#{r_fc_loc_code})\s+
Ports\slogged\sin:(\d+)\s+
Flags:(#{@r_flags})\s+
VFC\s+client\s+name:(fcs\d+|)\s+VFC\s+client\s+DRC:(#{r_client_drc})\s*$
}mx

    regexp_fmt = /(vfchost\d+):(#{r_physloc}):(\d+):(#{@r_lparname}):(AIX|):(#{@r_status}):(fcs\d+):(#{r_fc_loc_code}):(\d+):(\w+):(fcs\d+):(#{r_client_drc})/

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
      self.flags_short = match[10]
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
      self.flags       = match[10]
      @vfc_client_name = match[11]
      @vfc_client_drc  = match[12]

    else
      raise Exception, "Wrong string >#{string}<"
    end

  end

  def validate
    @errors = []
    @warnings = []

    return false unless @errors.empty?

    true
  end

  def to_s(separator = ':')
    "#{@name}#{separator}#{@physloc}#{separator}#{@clntid}#{separator}#{@clntname}#{separator}#{@clntos}" +
    "#{separator}#{@status}#{separator}#{fc_name}#{separator}#{@fc_loc_code}#{separator}#{@ports_logged_in}" +
    "#{separator}#{@flags_short}#{separator}#{@vfc_client_name}#{separator}#{@vfc_client_drc}"
  end

  def to_s_long_fixed
    "Name          Physloc                            ClntID ClntName       ClntOS
------------- ---------------------------------- ------ -------------- -------
#{@name}      #{@physloc}                #{@clntid} #{@clntname}          #{@clntos}

Status:#{@status}
FC name:#{fc_name}                    FC loc code:#{@fc_loc_code}
Ports logged in:#{@ports_logged_in}
Flags:#{@flags}
VFC client name:#{@vfc_client_name}    VFC client DRC:#{@vfc_client_drc}
"
  end

end