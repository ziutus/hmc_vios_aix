class Lsps_entry

  attr_reader :psname
  attr_reader :pvname
  attr_reader :vgname
  attr_reader :size
  attr_reader :used
  attr_reader :active
  attr_reader :auto
  attr_reader :type

  def initialize(string = '')
    @psname = nil
    @pvname = nil
    @vgname = nil
    @size = nil
    @used = nil
    @active = nil
    @auto = nil
    @type = nil

    parse(string) unless string.empty?
  end

  def parse(string = '')
    regexp = %r{^
([\w\_\-]+)\s+#Paging Space Name
([\w\_\-]+)\s+#PV name
([\w\_\-]+)\s+#VG name
(\d+MB)\s+ # size
(\d+)\s+ # used
(yes|no)\s+ #active
(yes|no)\s+ #auto
(lv)\s* #Type
$}x

    if match = regexp.match(string)
      @psname = match[1]
      @pvname = match[2]
      @vgname = match[3]
      @size = match[4]
      @used = match[5].to_i
      @active = match[6]
      @auto = match[7]
      @type = match[8]
    else
      raise Exception, "Can't parse string >#{string}<"
    end
    true
  end

end