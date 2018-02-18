require 'AIX/odmget_srcsubsys_entry'

class Odmget

  attr_reader :data
  attr_reader :data_string_raw

  def initialize(string)

    @data = Array.new
    @data_string_raw=''

    @odm_supported_class = %w(SRCsubsys)

    if string.length > 0
      @data_string_raw = string
      self.parse(string)
    end
  end

  def parse(string)

    entry = ''
    entry_title = ''

    string.split("\n").each do |line|

      if match = %r{^(\w+):\s*$}.match(line)

        self.parse_entry(entry_title, entry) if entry_title.length > 2 #let's ignore first run

        # let's create new entry
        entry_title = match[1]
        entry = line + "\n"
      else
        entry += line + "\n"
      end

    end

    self.parse_entry(entry_title, entry) if entry_title.length > 2 # last run and exlcude case that file (string) is empty
  end

  def parse_entry(odm_class, entry)

    raise "Unsuported ODM class '#{odm_class}'" unless @odm_supported_class.include?(odm_class)

    object = case odm_class
               when 'SRCsubsys' then Odmget_SRCsubsys.new(entry)
               else
                 raise "Unsuported ODM class '#{odm_class}'<"
             end

    @data.push(object)

    end
end