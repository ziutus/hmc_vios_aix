
# see: https://www.ibm.com/developerworks/aix/library/au-aix-decoding-location-codes/index.html
# see: https://www.ibm.com/support/knowledgecenter/POWER6/arecs/arecs.pdf

class LocationCode

  attr_accessor :location_code_raw
  attr_accessor :unit_enclosure_type
  attr_accessor :enclosure_model
  attr_accessor :serial_number
  attr_accessor :location

  attr_accessor :planar
  attr_accessor :device_slot
  attr_accessor :card
  attr_accessor :port

  attr_reader :_comment

  def initialize(string = nil)

    @unit_enclosure_type = nil
    @enclosure_model = nil
    @serial_number = nil
    @location = nil

    @planar = nil
    @virtual_planar = nil
    @device_slot = nil
    @card = nil
    @card2 = nil
    @port = nil

    @_comment = nil

    parse(string) unless string.nil?
  end

  def parse(string)
   @location_code_raw = string

   if match = /^\s*(\w{5})\.(\w{3})\.([\w#]{7})\-([CPDTV\d\-]+)\s*$/.match(string)
     @unit_enclosure_type = match[1]
     @enclosure_model = match[2]
     @serial_number = match[3]
     @location = parse_location(match[4])
   else
     raise Exception, "Can't parse string >#{string}<"
   end
  end

  # Code prefix	Description
  # A	Air moving device, for example,fan
  # C	Card, for example, PCI slots, memory slots
  # D	Devices, for example, disk slot, disk drawer
  # E	Electrical, for example, power supply
  # L	Logical path, for example, Fibre Channel
  # P	Planar, for example, a system or I/O back-plane, system board
  # T	Interface connector /Port, for example, serial port, usually followed by a number to denote which port
  # U	Unit
  # V	Virtual planar
  def parse_location(string)
    if match = /^P(\d+)\-D(\d+)$/.match(string)
      @planar = match[1]
      @device_slot = match[2]
    elsif match = /^P(\d+)\-T(\d+)$/.match(string)
      @planar = match[1]
      @port = match[2]
      @_comment = 'integral (on-board) port'
    elsif match = /^P(\d+)\-C(\d+)\-T(\d+)$/.match(string)
      @planar = match[1]
      @card = match[2]
      @port = match[3]
    elsif match = /^P\d+\-C\d+\-C\d+\-T\d+$/.match(string)
      @planar = match[1]
      @card = match[2]
      @card2 = match[3]
      @port = match[4]
    elsif match = /^V\d+\-C\d+$/.match(string)
      @virtual_planar = match[1]
      @card = match[2]
      @_comment = 'virtual planar'
    else
      raise Exception, "Wrong location code >#{string}<"
    end

    string
  end

  def self.regexp_string(type)
    if type == 'virtual_planar'
      '\w{5}\.\w{3}\.[\w#]{7}\-V\d+\-C\d+'
    elsif type == 'virtual_planar_client'
      '\w{5}\.\w{3}\.[\w#]{7}\-V\d+\-C\d+|\w{5}\.\w{3}\.[\w#]{7}\-V\d+\-C\d+\-T\d+'
    elsif type == 'physical_planar'
      '\w{5}\.\w{3}\.[\w#]{7}\-P\d+\-C\d+\-T\d+|\w{5}\.\w{3}\.[\w#]{7}\-P\d+\-C\d+\-C\d+\-T\d+'
    else
      raise Exception, "Wrong type of location code >#{type}<"
    end
  end

end