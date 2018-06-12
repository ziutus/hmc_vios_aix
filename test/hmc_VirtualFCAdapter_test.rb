$LOAD_PATH << File.dirname(__FILE__) + '/../inc'
$LOAD_PATH << File.dirname(__FILE__) + './inc'

require 'HMC/VirtualFCAdapter'
require 'test/unit'
require 'pp'

class TestVirtualFCAdapter < Test::Unit::TestCase

  # example data: http://www-01.ibm.com/support/docview.wss?uid=nas8N1011009
  def test_base
    adapter = VirtualFCAdapter.new

    adapter.virtualSlotNumber=10
    adapter.clientOrServer='client'
    adapter.remoteLparID=20
    adapter.remoteLparName='VIOS1-Dilling'
    adapter.remoteSlotNumber=34
    adapter.wwpn1='c0507602f9ac000a'
    adapter.wwpn2='c0507602f9ac000b'
    adapter.isRequired=1

    assert_equal('""10/client/20/VIOS1-Dilling/34/c0507602f9ac000a,c0507602f9ac000b/1""', adapter.to_s)
  end

  # example data: http://www-01.ibm.com/support/docview.wss?uid=nas8N1011009
  def test_decode

    string = '""10/client/20/VIOS1-Dilling/34/c0507602f9ac000a,c0507602f9ac000b/1""'
    adapter = VirtualFCAdapter.new
    adapter.decode(string)

    assert_equal(string, adapter.to_s)

    # virtual-slot-number/client-or-server/[remote-lpar-ID]/[remote-lpar-name]/remote-slot-number/[wwpns]/is-required
    assert_equal(10, adapter.virtualSlotNumber)
    assert_equal('client', 	adapter.clientOrServer)
    assert_equal(20, adapter.remoteLparID)
    assert_equal(34, adapter.remoteSlotNumber)
    assert_equal(1,	adapter.isRequired)

    assert_equal('VIOS1-Dilling', adapter.remoteLparName)
    assert_equal('c0507602f9ac000a', adapter.wwpn1)
    assert_equal('c0507602f9ac000b', adapter.wwpn2)
  end


  # https://www.ibm.com/developerworks/community/forums/html/threadTopic?id=77777777-0000-0000-0000-000014412555
  def test_decode_empty_wwpns

    #virtual-slot-number/client-or-server/[remote-lpar-ID]/[remote-lpar-name]/remote-slot-number/[wwpns]/is-required
    string = '21/server/10/bt11/21//0'
    adapter = VirtualFCAdapter.new
    adapter.decode(string)

    assert_equal(string, adapter.to_s)

    assert_equal(21, adapter.virtualSlotNumber)
    assert_equal('server', 	adapter.clientOrServer)
    assert_equal(10, adapter.remoteLparID)
    assert_equal(21, adapter.remoteSlotNumber)
    assert_equal(0, adapter.isRequired)

    assert_equal('bt11', adapter.remoteLparName)
#    assert_equal('c0507602f9ac000a', adapter.wwpn1)
#    assert_equal('c0507602f9ac000b', adapter.wwpn2)
  end

  ###
  #    Test for compare function
  ###

  # data source (a bit modified):     #https://www.ibm.com/developerworks/community/forums/html/threadTopic?id=77777777-0000-0000-0000-000014412555
  def test_compare_ClientorServer
    adapter1 = VirtualFCAdapter.new('21/client/10/bt11/21//1')
    adapter2 = VirtualFCAdapter.new('21/server/10/bt11/21//1')

    diff = adapter1.diff(adapter2, 'normal1', 'normal2')

    # assert_equal(1, diff.size)
    # assert_equal("in profile normal1 clientOrServer is setup to client but in profile normal2 to server ", diff[0])
  end

  # data source (a bit modified):     #https://www.ibm.com/developerworks/community/forums/html/threadTopic?id=77777777-0000-0000-0000-000014412555
  def test_compare_RemoteLparID
    adapter1 = VirtualFCAdapter.new('21/server/10/bt11/21//1')
    adapter2 = VirtualFCAdapter.new('21/server/11/bt11/21//1')

    diff = adapter1.diff(adapter2, 'normal1', 'normal2')

    # assert_equal(1, diff.size)
    # assert_equal("in profile normal1 remoteLparID is setup to 10 but in profile normal2 to 11 ", diff[0])
  end

  # data source (a bit modified):     #https://www.ibm.com/developerworks/community/forums/html/threadTopic?id=77777777-0000-0000-0000-000014412555
  def test_compare_RemoteLparName
    adapter1 = VirtualFCAdapter.new('21/server/11/bt11/21//1')
    adapter2 = VirtualFCAdapter.new('21/server/11/bt12/21//1')

    diff = adapter1.diff(adapter2, 'normal1', 'normal2')

    #assert_equal(1, diff.size)
    #assert_equal("in profile normal1 remoteLparName is setup to bt11 but in profile normal2 to bt12 ", diff[0])
  end

  # data source (a bit modified):     #https://www.ibm.com/developerworks/community/forums/html/threadTopic?id=77777777-0000-0000-0000-000014412555
  def test_compare_RemoteSlotNumber
    adapter1 = VirtualFCAdapter.new('21/server/11/bt11/21//1')
    adapter2 = VirtualFCAdapter.new('21/server/11/bt11/22//1')

    diff = adapter1.diff(adapter2, 'normal1', 'normal2')

    #assert_equal(1, diff.size)
    #assert_equal("in profile normal1 RemoteSlotNumber is setup to 21 but in profile normal2 to 22 ", diff[0])
  end

  # data source:     #https://www.ibm.com/developerworks/community/forums/html/threadTopic?id=77777777-0000-0000-0000-000014412555
  def test_diff
    adapter1 = VirtualFCAdapter.new('21/server/10/bt11/21//0')
    adapter2 = VirtualFCAdapter.new('21/server/10/bt11/22//1')

    diff = adapter1.diff(adapter2, 'normal1', 'normal2')

    assert_equal(2, diff.size)
    assert_equal(0, diff['isRequired']['normal1'])
    assert_equal(1, diff['isRequired']['normal2'])

    assert_equal(21, diff['remoteSlotNumber']['normal1'])
    assert_equal(22, diff['remoteSlotNumber']['normal2'])
  end

end