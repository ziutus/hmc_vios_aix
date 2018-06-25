class Lsmap_net_entry
  attr_reader :svea
  attr_reader :physloc
  attr_reader :sea
  attr_reader :backing
  attr_reader :bdphysloc
  attr_reader :status

  def initialize(string = nil)
    @physloc = nil
    @svea = nil
    @sea = nil
    @backing = nil
    @bdphysloc = nil
    @status = nil

    parse(string) unless string.empty?
  end

  def parse(string)

    regexp_no_device = %r{^\s*SVEA\s+Physloc\s+
\s*[-\s]+\s*
\s*(ent\d+)\s+(\w{5}.\w{3}.\w{6,7}-V\d+-C\d+-T\d+)\s+
\s*SEA\s+NO\s+SHARED\s+ETHERNET\s+ADAPTER\s+FOUND\s*$}x

    regexp = %r{^\s*SVEA\s+Physloc\s+
\s*[-]+\s+[-]+\s+
\s*(ent\d+)\s+(\w{5}.\w{3}.\w{7}-V\d+-C\d+-T\d+)\s+
\s+
\s*SEA\s+(ent\d+)\s+
\s*Backing\s+device\s+(ent\d+)\s+
\s*Physloc\s+(\w{5}.\w{3}.\w{7}-P\d+-C\d+-T\d+)\s*$
}x

    regexp_with_status = %r{^\s*SVEA\s+Physloc\s+
\s*[-\s]+\s*
\s*(ent\d+)\s+(\w{5}.\w{3}.\w{6,7}-V\d+-C\d+-T\d+)\s+
\s*SEA\s+(ent\d+)\s+
\s*Backing\s+device\s+(ent\d+)\s+
\s*Status\s+(Available)\s+
\s*Physloc\s+(\w{5}.\w{3}.\w{6,7}-P\d+-C\d+-T\d+|\w{5}.\w{3}.\w{6,7}-P\d+-T\d+)\s*$
}x

    if match = regexp_no_device.match(string)
      @svea = match[1]
      @physloc = match[2]
    elsif match = regexp.match(string)
      @svea = match[1]
      @physloc = match[2]
      @sea = match[3]
      @backing = match[4]
      @bdphysloc = match[5]
    elsif match = regexp_with_status.match(string)
      @svea = match[1]
      @physloc = match[2]
      @sea = match[3]
      @backing = match[4]
      @status = match[5]
      @bdphysloc = match[6]
    else
      raise Exception, "Wrong string >#{string}<"
    end
  end

end