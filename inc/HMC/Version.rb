class Version

  attr_reader :version
  attr_reader :release
  attr_reader :servicePack
  attr_reader :hmcBuildLevel
  attr_reader :base_version
  attr_reader :patches
  attr_reader :patches_raw

  def initialize(string = '')

    @patches = {}
    parse(string) unless string.empty?
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
      @version = match[1]
      @release	= match[2]
      @servicePack = match[3]
      @hmcBuildLevel 	= match[4]
      @patches_raw	= match[5]
      @base_version = match[6]

      parse_patches(@patches_raw) unless @patches_raw.empty?

    else
      puts string
      puts regexp
      puts match
      puts "regexp couldn't decode string #{string}"
      raise

    end
  end

  def parse_patches(string)

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

  def hasFix?(fix_name)
    @patches.key?(fix_name)
  end

  def version_cmd
    'lshmc -V'
  end
end