require 'AIX/lsmpio_entry'

class Lsmpio_disk

  attr_accessor :data_string_raw
  attr_accessor :viosname
  attr_reader :name

  attr_reader :paths

  def initialize(string = '')
    @name = nil
    @paths = {}
    parse(string) unless string.empty?
  end

  def parse(string)
    @data_string_raw = string

    regexp = %r{(hdisk\d+)\s+(\d+)\s+(Enabled|Disabled|Failed|Missing)\s+([\w\,]+)\s+(fscsi\d+)\s+(\w+)\,(\w+)}
    string.each_line do |line|

      line = line.strip
      next if line =~ /name/
      next if line =~ /^\s*$/
      next if line =~ /^[=]+$/

      if match = regexp.match(line)
        path = Lsmpio_entry.new(line)
        @paths[path.path_id] = path
        if @name.nil?
          @name = path.name
        else
          raise "Inconsistance data: #{line}" if @name != path.name
        end
      else
        raise "Wrong line:>#{line}<"
      end
    end
  end
end