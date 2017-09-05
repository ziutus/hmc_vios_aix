class Version

  attr_reader :version, :release, :servicePack, :hmcBuildLevel, :base_version
  attr_reader :patches


  def initialize string

    if string.length > 0
        self.parse(string)
    end
  end

  def parse(string)

    regexp_all = %r{Version:\s(\d)\s+
\s+Release:\s+(\d\.\d\.\d)\s+
\s+Service\sPack:\s+(\d+)\s+
\s+HMC\sBuild\slevel\s([\d\.]+)\s*
(.*)\s*\"\,\"base_version=(V\dR\d\.\d\.\d)\s+
\s+\"}x

    regexp = %r{Version:\s(\d)\s+
\s+Release:\s+(\d\.\d\.\d)\s+
\s+Service\sPack:\s+(\d+)\s+
HMC\sBuild\slevel\s([\d\.]+)\s*
(.*)\s*
\"\,\"base_version=(V\dR\d\.\d\.\d)\s+
}x


    match = regexp.match(string)

#    attr_reader :version, :release, :servicePack, :hmcBuildlevel, :base_version

    if match
      @version        = match[1]
      @release		    = match[2]
      @servicePack 		= match[3]
      @hmcBuildLevel 	= match[4]
      @patches 		    = match[5]
      @base_version 	= match[6]

    else
      puts string
      puts regexp
      puts match
      puts "regexp couldn't decode string #{string}"
      raise

    end

  end

  def hasFix(fixName)

    print "this HMC has pathes like:"
    print "----"
    print @pathes
    print "----"

    return 0
  end

end