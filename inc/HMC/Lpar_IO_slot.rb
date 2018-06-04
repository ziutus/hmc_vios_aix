require 'pp'

class Lpar_IO_slot

  attr_accessor :slot_DRC_index
  attr_accessor :slot_IO_pool_ID
  attr_accessor :is_required

  attr_reader :data_string_raw

  def initialize(string)
    @slot_DRC_index = nil
    @slot_IO_pool_ID = 'none'
    @is_required = 0
    @data_string_raw = nil

    parse(string) unless string.empty?
  end

  def parse(string)
    @data_string_raw = string

    regexp = %r{^\s*(\w+)\/(none|d+)\/([01])\s*$}

    if match = regexp.match(string)
      @slot_DRC_index = match[1]
      @slot_IO_pool_ID = match[2]
      @is_required = match[3].to_i
    else
      pp string
      pp regexp
      pp match
      raise 'wrong string to parse'
    end
  end

  def to_s
    "#{@slot_DRC_index}/#{@slot_IO_pool_ID}/#{is_required}"
  end
end