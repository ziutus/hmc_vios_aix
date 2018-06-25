require 'pp'
require 'VIOS/lsmap_npiv_entry'

class Lsmap_net
  attr_reader :data
  attr_reader :data_string_raw

  def initialize(string = '')
    @data = {}
    @data_string_raw = ''
    parse(string) unless string.empty?
  end

  def parse(string)
    @data_string_raw = string

    string.gsub!("\nSVEA", '--split--SVEA').split('--split--').each do |str|
      entry = Lsmap_net_entry.new(str)
      @data[entry.svea] = entry
    end

    @data
  end
end