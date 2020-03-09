class Ifconfig_interface

  attr_reader :string_raw
  attr_reader :name
  attr_reader :flags_raw
  attr_reader :inet
  attr_reader :inet6
  attr_reader :netmask
  attr_reader :broadcast
  attr_reader :tcp_sendspace
  attr_reader :tcp_recvspace
  attr_reader :rfc1323

  def initialize(string = '')
    @interface_raw = []
    parse(string) unless string.empty?
  end

  def parse(string)
    @string_raw = string

    regexp_ipv4 = %r{^(\w+\d+):\s+flags=([\w\,]+)\s*
\s+inet\s+(\d{1,3}\.\d{1,3}\.\d{1,3}\.\d{1,3})\s+netmask\s+(0x\w+)\s+broadcast\s+(\d{1,3}\.\d{1,3}\.\d{1,3}\.\d{1,3})\s*
\s+tcp_sendspace\s+(\d+)\s+tcp_recvspace\s+(\d+)\s+rfc1323\s+(\d)\s*$
}mx

    regexp_ipv6 = %r{^(\w+\d+):\s+flags=([\w\,]+)\s*
\s+inet\s+(\d{1,3}\.\d{1,3}\.\d{1,3}\.\d{1,3})\s+netmask\s+(0x\w+)\s+broadcast\s+(\d{1,3}\.\d{1,3}\.\d{1,3}\.\d{1,3})\s*
\s+inet6\s+([\:\%\/\d]+)\s*
\s+tcp_sendspace\s+(\d+)\s+tcp_recvspace\s+(\d+)\s+rfc1323\s+(\d)\s*$
}mx

    if match = regexp_ipv4.match(string)
      @name = match[1]
      @flags_raw = match[2]
      @inet = match[3]
      @netmask = match[4]
      @broadcast = match[5]
      @tcp_sendspace = match[6].to_i
      @tcp_recvspace = match[7].to_i
      @rfc1323 = match[8].to_i
    elsif match = regexp_ipv6.match(string)
      @name = match[1]
      @flags_raw = match[2]
      @inet = match[3]
      @netmask = match[4]
      @broadcast = match[5]
      @inet6 = match[6]
      @tcp_sendspace = match[7].to_i
      @tcp_recvspace = match[8].to_i
      @rfc1323 = match[9].to_i
    else
      raise "Class:Unix:ifconfig_interface, function: parse, RegExp couldn't decode string >>#{string}<<"
    end
  end

end