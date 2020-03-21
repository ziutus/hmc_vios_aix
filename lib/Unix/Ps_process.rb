$LOAD_PATH << File.dirname(__FILE__)+"./lib"
$LOAD_PATH << File.dirname(__FILE__)

require 'pp'

class Ps_process

  attr_reader    :uid
  attr_reader    :pid
  attr_reader    :ppid
  attr_reader    :c
  attr_reader    :stime
  attr_reader    :tty
  attr_reader    :time
  attr_reader    :cmd
  attr_accessor  :children

  def initialize (string = '')
    @children = 0

    decode(string) unless string.empty?
  end

  def decode(string)

    regexp = %r{(\w+)\s+ #UID
    (\d+)\s+ #PID
    (\d+)\s+ #PPID
    (\d+)\s+ # CPU TIME (C)
    (\w{3}\d{1,2}|\d{1,2}:\d{1,2}|)\s+ #Strat Time
    (\?|pts\/\d+|tty\d+|)\s+ #Console
    (\d{1,2}:\d{1,2}:\d{1,2}|\d+-\d{1,2}:\d{1,2}:\d{1,2}|\d{1,2}:\d{1,2})\s+  #TIME
    (.*) # command
    }x
    match = regexp.match(string)

    unless match
      puts string
      puts regexp
      puts match
      puts "regexp couldn't decode string #{string}"
      raise
    end

    @uid   = match[1]
    @pid   = match[2].to_i
    @ppid  = match[3].to_i
    @c     = match[4].to_i # C     pcpu         cpu utilization
    @stime = match[5]
    @tty   = match[6]
    @time  = match[7]
    @cmd   = match[8]
  end

end