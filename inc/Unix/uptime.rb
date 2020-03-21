class Uptime

  attr_reader :time
  attr_reader :up
  attr_reader :users
  attr_reader :load
  attr_reader :load_1
  attr_reader :load_5
  attr_reader :load_15

  def initialize(string = '')
    @time = nil
  end

  def parse_simple(string)

    regexp = %r{^\s*(\d+:\d+:\d+)\s # current time
up\s+(\d+\sdays,\s*\d+:\d+|\d+:\d+|\d+\s+min), #how long system is up?
\s*(\d+)\suser(?:|s),\s+ # how many users are logged in
load\saverage:\s+(\d+,\d+),\s+(\d+,\d+),\s+(\d+,\d+)\s*$ #load average from last 1 min, 5 mins and 15 mins
}x

    lines = string.split("\n")
    if match = regexp.match(lines[0])
      @time = match[1]
      @up = match[2]
      @users = match[3].to_i
      @load = "#{match[4]}, #{match[5]}, #{match[6]}"
      @load_1 = match[4]
      @load_5 = match[5]
      @load_15 = match[6]
    else
      raise Exception, "Can't parse string >#{lines[0]}<"
    end

  end
end