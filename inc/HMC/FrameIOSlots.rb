require 'pp'
require 'HMC/FrameIOSlot'

class FrameIOSlots

  attr_reader :data_string_raw

  def initialize(string = '')

    @array = Array.new()

    unless string.empty?
      @data_string_raw = string
      parse(string)
    end
  end

  def parse(string)

    string.each_line do |line|
      @array << FrameIOSlot.new(line)
    end

  end

  def get_lpar(lpar)
    @array.each do |slot|
      # if lpar == slot.lpar_name
        # pp  slot.lpar_name.to_s + " " + slot.description
      # end
    end
  end
end