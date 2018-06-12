$LOAD_PATH << File.dirname(__FILE__) + '/../inc'
$LOAD_PATH << File.dirname(__FILE__) + './inc'

require 'HMC/VirtualScsiAdapter'
require 'test/unit'

class TestVirtualScsiAdapter < Test::Unit::TestCase
 
  def test_base
    adapter = VirtualScsiAdapter.new
    adapter.virtualSlotNumber = 1
    adapter.clientOrServer		= 'client'
    adapter.remoteLparID		  = 2
    adapter.remoteLparName		= 'lpar2'
    adapter.remoteSlotNumber	= 3
    adapter.isRequired			  = 1

    #virtual-slot-number/client-or-server/[remote-lpar-ID]/[remote-lpar-name]/[remote-slot-number]/is-required
    assert_equal('1/client/2/lpar2/3/1', adapter.to_s)
  end

  def test_bas2
  #
    adapter2 = VirtualScsiAdapter.new
    adapter2.decode('2/server/5/nim1/3/0')

    assert_equal(2, 	    adapter2.virtualSlotNumber)
    assert_equal('server',adapter2.clientOrServer)
    assert_equal(5, 	    adapter2.remoteLparID)
    assert_equal('nim1',  adapter2.remoteLparName)
    assert_equal(3, 	    adapter2.remoteSlotNumber)
    assert_equal(0, 	    adapter2.isRequired)
  end

  # def test_decode_real_adapter
  #
  # 	adapter = VirtualScsiAdapter.new
  # 	adapter.decode('slot_num=8,state=0,is_required=0,adapter_type=server,remote_lpar_id=8,remote_lpar_name=null,remote_slot_num=2')
  #
  # 	assert_equal(8, 	    adapter.virtualSlotNumber)
  # 	assert_equal('server',adapter.clientOrServer)
  # 	assert_equal(8, 	    adapter.remoteLparID)
  # 	assert_equal('null',  adapter.remoteLparName)
  # 	assert_equal(2, 	    adapter.remoteSlotNumber)
  # 	assert_equal(0, 	    adapter.isRequired)
  #
  # end

  def test_any_any
    adapter = VirtualScsiAdapter.new
    adapter.decode('2/server/any//any/0')

    assert_equal(2, adapter.virtualSlotNumber)
    assert_equal('server', adapter.clientOrServer)
    assert_equal('any', adapter.remoteLparID)
    assert_equal('', adapter.remoteLparName)
    assert_equal('any', adapter.remoteSlotNumber)
    assert_equal(0, adapter.isRequired)

    assert_equal('2/server/any//any/0', adapter.to_s)

  end

  def test_validation_1
    adapter = VirtualScsiAdapter.new

    exception = assert_raise(RuntimeError) { adapter.to_s }
    assert_equal('virtualSlotNumber not defined', exception.message)
  end

  def test_validation_2
    adapter = VirtualScsiAdapter.new
    adapter.virtualSlotNumber = 'defined'

    exception = assert_raise(RuntimeError) { adapter.to_s }
    assert_equal('virtualSlotNumber is not number', exception.message)
  end

  def test_can_parse
    adapter = VirtualScsiAdapter.new

    assert_equal(true, adapter.can_parse?('lpar_name=vios1,lpar_id=2,slot_num=2,state=1,is_required=1,adapter_type=server,remote_lpar_id=5,remote_lpar_name=nim1,remote_slot_num=2'))
  end

  def test_real_1
    string = 'lpar_name=vios1,lpar_id=2,slot_num=2,state=1,is_required=1,adapter_type=server,remote_lpar_id=5,remote_lpar_name=nim1,remote_slot_num=2'
    adapter = VirtualScsiAdapter.new(string)

    assert_equal('vios1', adapter.lpar_name)
    assert_equal(2, adapter.lpar_id)
    assert_equal(2, adapter.virtualSlotNumber)
    assert_equal(1, adapter.state)
    assert_equal(1, adapter.isRequired)
    assert_equal('server', adapter.clientOrServer)
    assert_equal(5, adapter.remoteLparID)
    assert_equal('nim1', adapter.remoteLparName)
    assert_equal(2, adapter.remoteSlotNumber)
    assert_equal(string, adapter.to_s)

  end

  def test_diff
    adapter1 = VirtualScsiAdapter.new('2/server/any//any/0')
    adapter2 = VirtualScsiAdapter.new('2/client/any//any/1')

    diff = adapter1.diff(adapter2, 'profile1', 'profile2')
    assert_equal(2, diff.keys.count)
    assert_equal(0, diff['isRequired']['profile1'])
    assert_equal(1, diff['isRequired']['profile2'])

    assert_equal('server', diff['clientOrServer']['profile1'])
    assert_equal('client', diff['clientOrServer']['profile2'])
  end

  end