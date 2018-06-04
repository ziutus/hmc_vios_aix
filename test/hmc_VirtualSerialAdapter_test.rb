$LOAD_PATH << File.dirname(__FILE__) + '/../inc'
$LOAD_PATH << File.dirname(__FILE__) + './inc'

require 'HMC/VirtualSerialAdapter'
require 'test/unit'
require 'pp'

class TestVirtualSerialAdapter < Test::Unit::TestCase
 
  def test_base
    adapter = VirtualSerialAdapter.new
    adapter.virtualSlotNumber=0
    adapter.clientOrServer='server'
    adapter.supportsHMC=1
    adapter.remoteLparID='any'
    adapter.remoteLparName=''
    adapter.remoteSlotNumber='any'
    adapter.isRequired=1

    #virtual-slot-number/client-or-server/[supports-HMC]/[remote-lpar-ID]/[remote-lpar-name]/[remote-slot-number]/is-required
    assert_equal('0/server/1/any//any/1', adapter.to_s )
  end

  def test_decode

    adapter = VirtualSerialAdapter.new
    adapter.decode('0/server/1/any//any/1')

    assert_equal(0, adapter.virtualSlotNumber)
    assert_equal('server', adapter.clientOrServer)
    assert_equal(1, 	     adapter.supportsHMC)
    assert_equal('any', 	 adapter.remoteLparID)
    assert_equal('', adapter.remoteLparName)
    assert_equal('any', 	 adapter.remoteSlotNumber)
    assert_equal(1, 	     adapter.isRequired)
  end

  def test_compare1

    adapter1 = VirtualSerialAdapter.new('0/server/1/any//any/1')
    adapter2 = VirtualSerialAdapter.new('0/server/1/any//any/0')
    adapter3 = VirtualSerialAdapter.new('0/server/1/any//any/1')

    assert_equal(false, adapter2 == adapter3, 'is adapter2 the same like adapter3')
    assert_equal(true,  adapter1 == adapter3, 'is adapter1 the same like adapter3')

  end

  def test_can_parse
    adapter = VirtualSerialAdapter.new

    assert_equal(true, adapter.can_parse?('lpar_name=nim1,lpar_id=5,slot_num=1,state=0,is_required=1,connect_status=unavailable,adapter_type=server,supports_hmc=1,remote_lpar_id=any,remote_lpar_name=,remote_slot_num=any'))
    assert_equal(true, adapter.can_parse?('0/server/1/any//any/1'))
  end

  # data source: own power5 frame
  def test_real_1
    string = 'lpar_name=nim1,lpar_id=5,slot_num=1,state=0,is_required=1,connect_status=unavailable,adapter_type=server,supports_hmc=1,remote_lpar_id=any,remote_lpar_name=,remote_slot_num=any'

    adapter = VirtualSerialAdapter.new
    adapter.decode(string)

    assert_equal(5, adapter.lpar_id)
    assert_equal('nim1', adapter.lpar_name)
    assert_equal(1, 	     adapter.virtualSlotNumber)
    assert_equal(0, 	     adapter.state)
    assert_equal(1, 	     adapter.isRequired)
    assert_equal('unavailable', adapter.connectStatus)
    assert_equal('server', adapter.clientOrServer)
    assert_equal(1, adapter.supportsHMC)
    assert_equal('any', adapter.remoteLparID)
    assert_equal('', adapter.remoteLparName)
    assert_equal('any', adapter.remoteSlotNumber)
  end

end