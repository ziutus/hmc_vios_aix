$LOAD_PATH << File.dirname(__FILE__)+'/../lib'
$LOAD_PATH << File.dirname(__FILE__)+'./lib'

require 'test/unit'
require 'Unix/ifconfig_interface'
require 'pp'

class Unix_ifconfig_interface_Test < Test::Unit::TestCase

  # test data source https://datageek.blog/en/2017/02/28/finding-the-subnet-mask-on-aix/
  def test_infconfig_en0

    data_string='
en0: flags=1e084863,480
        inet 192.0.2.236 netmask 0xfffffc00 broadcast 192.0.2.255
         tcp_sendspace 262144 tcp_recvspace 262144 rfc1323 1'

    interface = Ifconfig_interface.new(data_string)

    assert_equal(data_string, interface.string_raw)
    assert_equal('en0', interface.name)

  end

  def test_infconfig_lo0

    data_string='
lo0: flags=e08084b,c0
        inet 127.0.0.1 netmask 0xff000000 broadcast 127.255.255.255
        inet6 ::1%1/0
         tcp_sendspace 131072 tcp_recvspace 131072 rfc1323 1'

    interface = Ifconfig_interface.new(data_string)

    assert_equal(data_string, interface.string_raw)
    assert_equal('lo0', interface.name)
    assert_equal('e08084b,c0', interface.flags_raw)
    assert_equal('127.0.0.1', interface.inet)
    assert_equal('0xff000000', interface.netmask)
    assert_equal('127.255.255.255', interface.broadcast)
    assert_equal('::1%1/0', interface.inet6)
    assert_equal(131_072, interface.tcp_sendspace)
    assert_equal(131_072, interface.tcp_recvspace)
    assert_equal(1, interface.rfc1323)

  end

end