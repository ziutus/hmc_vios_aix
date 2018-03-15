require 'pp'
require 'VIOS/lsmap_npiv_entry'

class Lsmap_npiv

  attr_reader :data
  attr_reader :data_string_raw

  def initialize(string)

    @data = Hash.new
    @data_string_raw=''
    if string.length > 0
      @data_string_raw = string
      self.parse(string)
    end
  end

  def parse(string)

    string.gsub!("\nName", "--split--Name")

    array = string.split("--split--")
    array2 = Array.new

    array.each { |str|
        entry = Lsmap_npiv_entry.new(str)
        @data[entry.name] = entry
    }

    @data
  end
end