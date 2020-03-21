$LOAD_PATH << File.dirname(__FILE__)+'/../lib'
$LOAD_PATH << File.dirname(__FILE__)+'./lib'

require 'test/unit'
require 'Unix/Ifconfig'
require 'pp'

class Unix_ifconifg_Test < Test::Unit::TestCase

  # test data source https://datageek.blog/en/2017/02/28/finding-the-subnet-mask-on-aix/
  def test_compare_odm_running_O

    data_string='
en0: flags=1e084863,480
        inet 192.0.2.236 netmask 0xfffffc00 broadcast 192.0.2.255
        tcp_sendspace 262144 tcp_recvspace 262144 rfc1323 1
lo0: flags=e08084b,c0
        inet 127.0.0.1 netmask 0xff000000 broadcast 127.255.255.255
        inet6 ::1%1/0
        tcp_sendspace 131072 tcp_recvspace 131072 rfc1323 1'

    ifconfig = Ifconfig.new(data_string)

    assert_equal(data_string, ifconfig.string_raw)
    assert_equal(2, ifconfig.interfaces.length)
    assert_equal('en0', ifconfig.interfaces['en0'].name)
    assert_equal('lo0', ifconfig.interfaces['lo0'].name)
  end
end