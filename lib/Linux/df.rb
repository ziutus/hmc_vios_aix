require 'Linux/df_entry'

class Df

  attr_reader :table

  attr_writer :system

  def initialize(string = nil, system = nil)

    @system = system
    @table = {}

    parse(string) unless string.nil?
  end

  def parse(string)

    string.each_line do |s|

      next if s =~ /^\s*Filesystem\s+Size\s+Used\s+Avail\s+Use\%\s+Mounted\s+on\s*$/
      next if s =~ /^\s*Filesystem\s+1024\-blocks\s+Used\s+Available\s+Capacity\s+Mounted\s+on\s*$/

      entry = Df_entry.new(s, @system)
      @table[entry.mounted_on] = entry

    end

  end

end