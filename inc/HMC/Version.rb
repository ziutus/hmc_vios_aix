class Version

  attr_reader :version, :release, :servicePack, :hmcBuildLevel, :base_version
  attr_reader :patches, :patches_raw


  def initialize string=''

	@patches = Hash.new()
  
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

    if match
      @version        = match[1]
      @release		    = match[2]
      @servicePack 		= match[3]
      @hmcBuildLevel 	= match[4]
      @patches_raw	    = match[5]
      @base_version 	= match[6]

        if @patches_raw.length > 0
          parsePatches(@patches_raw)
        end

    else
      puts string
      puts regexp
      puts match
      puts "regexp couldn't decode string #{string}"
      raise

    end
  end

  def parsePatches string

    regexp = %r{(MH\d{5})\:(.*)}
    match = regexp.match(string)

    if match
      version        = match[1]
      description	 = match[2]
	  
 	  @patches[version] = description			  
    else
      puts string
      puts regexp
      puts match
      puts "regexp couldn't decode string #{string}"
      raise

    end

  end

  def hasFix?(fixName)
    return @patches.has_key?(fixName)
  end

  def version_cmd
    'lshmc -V'
  end
end