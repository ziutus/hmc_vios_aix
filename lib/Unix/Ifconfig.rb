require 'Unix/ifconfig_interface'

class Ifconfig

  attr_reader :string_raw
  attr_reader :interfaces_raw
  attr_reader :interfaces

  def initialize(string = '')
    @interfaces_raw = []
    @interfaces = {}
    parse(string) unless string.empty?
  end

  def parse(string)
    @string_raw = string

    interface_raw = ''
    string.each_line do |line|
      next if (line =~ /^\s*$/)
      if (line =~ /^\w+\d+:/)
        @interfaces_raw.push(interface_raw) unless interface_raw.empty?
        interface_raw = line
      else
        interface_raw += line + "\n"
      end
    end
    @interfaces_raw.push(interface_raw) unless interface_raw.empty?

    @interfaces_raw.each do |string|
      interface = Ifconfig_interface.new(string)
      @interfaces[interface.name] = interface
    end
  end
end
