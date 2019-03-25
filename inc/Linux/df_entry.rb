class Df_entry

  attr_accessor :system
  attr_reader :filesystem
  attr_reader :size
  attr_reader :used
  attr_reader :available
  attr_reader :used_percent
  attr_reader :mounted_on

  def initialize(string = nil, system = nil )

    @system = system

    parse(string) unless string.nil?
  end

  def parse(string)

    regexp = %r{([\w\/\_\-]+)\s+ #Filesystem
    ([\d\.MGK]+)\s+ #Size
    ([\d\.MGK]+)\s+ #Used
    ([\d\.MGK]+)\s+ # Available
    (\d+)\%\s+ #Used procent
    ([\w\/]+)\s* #Mounted on
  }x
    match = regexp.match(string)

    unless match
      puts string
      puts regexp
      puts match
      puts "regexp couldn't decode string #{string}"
      raise
    end

    @filesystem   = match[1]
    @size   = match[2]
    @used  = match[3]
    @available     = match[4]
    @used_percent = match[5]
    @mounted_on   = match[6]
  end

end