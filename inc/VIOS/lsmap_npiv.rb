require 'pp'
require 'VIOS/lsmap_npiv_entry'

class Lsmap_npiv

  attr_accessor :data
  attr_reader :data_string_raw

  attr_reader :fc_names

  attr_accessor :vios
  attr_accessor :sys

  def initialize(string = nil, vios = nil, sys = nil)
    @vios = vios
    @sys = sys

    @data = {}
    @data_string_raw = ''
    parse(string) unless string.nil? or string.empty?
  end

  def parse(string)
    @data_string_raw = string

    if string =~ /Name\s*Physloc/
      string.gsub("\nName", '--split--Name').split('--split--').each do |str|
        entry = Lsmap_npiv_entry.new(str)
        entry.vios = @vios
        entry.sys = @sys
        @data[entry.name] = entry
      end
    else
      string.each_line do |line|
        entry = Lsmap_npiv_entry.new(line)
        entry.vios = @vios
        entry.sys = @sys
        @data[entry.name] = entry
      end
    end
    working_fcs
    @data
  end

  def mapping_for_lpar_id(lpar_id)
    result = []
    @data.each_pair do |name, entry|
      result.push(entry) if entry.clntid == lpar_id
    end
    result
  end

  def to_s(separator = ':')
    result = ''
    @data.each_pair do |name, entry|
      result += entry.to_s(separator)
    end

    result
  end

  def working_fcs
    result = []
    @data.each_pair do |name, entry|
      result.push(entry.fc_name)
    end
    @fc_names = result.uniq
    @fc_names
  end

  def using_fcs?(name)
    @fc_names.include?(name)
  end
end