class Odmget_SRCsubsys

  attr_reader :data_string_raw
  attr_reader :subsysname
  attr_reader :synonym
  attr_reader :cmdargs
  attr_reader :path
  attr_reader :uid
  attr_reader :auditid
  attr_reader :standin
  attr_reader :standout
  attr_reader :standerr
  attr_reader :action
  attr_reader :multi
  attr_reader :contact
  attr_reader :svrkey
  attr_reader :svrmtype
  attr_reader :priority
  attr_reader :signorm
  attr_reader :sigforce
  attr_reader :display
  attr_reader :waittime
  attr_reader :grpname

  def initialize(string)

    @data_string_raw=''

    @subsysname = ''
    @synonym = ''
    @cmdargs = ''
    @path = ''
    @uid = ''
    @auditid = ''
    @standin = ''
    @standout = ''
    @standerr = ''
    @action = 0
    @multi = 0
    @contact = 0
    @svrkey = 0
    @svrmtype = 0
    @priority = 20
    @signorm = 0
    @display = 0
    @waittime = 0
    @grpname = ''


    if string.length > 0
      @data_string_raw = string
      self.parse(string)
    end
  end

  def parse(string)

    regexp = %r{SRCsubsys:\s
\s+subsysname\s*=\s*"(\w+)"\s
\s+synonym\s*=\s*"(\w*)"\s
\s+cmdargs\s*=\s*"([\w\s*\-]*)"\s
\s+path\s*=\s*"([\w\s*\-\/]*)"\s
\s+uid\s*=\s*(\d+)\s
\s+auditid\s*=\s*(\d+)\s
\s+standin\s*=\s*"([\w\s*\-\/]*)"\s
\s+standout\s*=\s*"([\w\s*\-\/]*)"\s
\s+standerr\s*=\s*"([\w\s*\-\/]*)"\s
\s+action\s*=\s*(\d+)\s
\s+multi\s*=\s*(\d+)\s
\s+contact\s*=\s*(\d+)\s
\s+svrkey\s*=\s*(\d+)\s
\s+svrmtype\s*=\s*(\d+)\s
\s+priority\s*=\s*(\d+)\s
\s+signorm\s*=\s*(\d+)\s
\s+sigforce\s*=\s*(\d+)\s
\s+display\s*=\s*(\d+)\s
\s+waittime\s*=\s*(\d+)\s
\s+grpname\s*=\s*"(\w*)"}x




    if match = regexp.match(string)
      @subsysname = match[1]
      @synonym    = match[2]
      @cmdargs    = match[3]
      @path       = match[4]
      @uid        = match[5].to_i
      @auditid    = match[6].to_i
      @standin    = match[7]
      @standout   = match[8]
      @standerr   = match[9]
      @action     = match[10].to_i
      @multi      = match[11].to_i
      @contact    = match[12].to_i
      @svrkey     = match[13].to_i
      @svrmtype   = match[14].to_i
      @priority   = match[15].to_i
      @signorm    = match[16].to_i
      @sigforce   = match[17].to_i
      @display    = match[18].to_i
      @waittime   = match[19].to_i
      @grpname    = match[20]

    else
      puts "can't analyze string, regexp is not working"
      puts string
      raise 'odmget_srcsubsys - regexp is not working'

    end
  end

end