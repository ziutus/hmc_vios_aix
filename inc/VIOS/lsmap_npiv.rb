require 'pp'
require 'VIOS/lsmap_npiv_entry'

class Lsmap_npiv

  attr_reader :data
  attr_reader :data_string_raw

  def initialize(string = '')
    @data = {}
    @data_string_raw = ''
    parse(string) unless string.empty?
  end

  def parse(string)
    @data_string_raw = string

    string.gsub("\nName", '--split--Name').split('--split--').each do |str|
      entry = Lsmap_npiv_entry.new(str)
      @data[entry.name] = entry
    end
    @data
  end

  def mapping_for_lpar_id(lpar_id)
    result = []
    @data.each_pair do |name, entry|
      result.push(entry) if entry.clntid == lpar_id
    end
    result
  end

end