$LOAD_PATH << File.dirname(__FILE__) + '/../inc'
$LOAD_PATH << File.dirname(__FILE__) + './inc'

require 'HMC/VirtualEthAdapter'
require 'test/unit'

#TODO: using own power5 prepare more test cases

class TestVirtualEthAdapter < Test::Unit::TestCase
 
  def test_base
    adapter = VirtualEthAdapter.new
    adapter.virtualSlotNumber=6
    adapter.isIEEE=0
    adapter.portVlanID=6
    adapter.additionalVlanIDs=''
    adapter.trunkPriority=2
    adapter.isRequired=1

    assert_equal('6/0/6//2/1', adapter.to_s )
  end

  def test_decode

    adapter2 = VirtualEthAdapter.new
    adapter2.decode('6/0/6//2/1')

#virtual-slot-number/is-IEEE/port-vlan-ID/[additional-vlan-IDs]/[trunk-priority]/is-required[/[virtual-switch][/[MAC-address]/ 
#[allowed-OS-MAC-addresses]/[QoS-priority]]]

    assert_equal(6, adapter2.virtualSlotNumber)
    assert_equal(0, adapter2.isIEEE)
    assert_equal(6, adapter2.portVlanID)
    assert_equal('',adapter2.additionalVlanIDs)
    assert_equal(2, adapter2.trunkPriority)
    assert_equal(1, adapter2.isRequired)
  end

  def test_vswitch_name

    adapter = VirtualEthAdapter.new('10/0/1//0/0/ETHERNET0//all/none')

    assert_equal(10, adapter.virtualSlotNumber)
    assert_equal(0,  adapter.isIEEE)
    assert_equal(1,  adapter.portVlanID)
    assert_equal('', adapter.additionalVlanIDs)
    assert_equal(0,  adapter.trunkPriority)
    assert_equal(0,  adapter.isRequired)
    assert_equal('ETHERNET0', adapter.virtualSwitch)

    assert_equal('',     adapter.macAddress)
    assert_equal('all',  adapter.allowedOsMacAddresses)
    assert_equal('none', adapter.qosPiority)
  end


  def test_vlans
    adapter = VirtualEthAdapter.new('2/1/1/3,4,5/0/1')
    assert_equal('""2/1/1/3,4,5/0/1""', adapter.to_s)
  end

  def test_can_parse
    adapter = VirtualEthAdapter.new
    assert_equal(true, adapter.can_parse?('6/0/6//2/1'))
    assert_equal(true, adapter.can_parse?('10/0/1//0/0/ETHERNET0//all/none'))
    assert_equal(true, adapter.can_parse?('2/1/1/3,4,5/0/1'))
    assert_equal(true, adapter.can_parse?('lpar_name=dump,lpar_id=1,slot_num=2,state=0,is_required=1,is_trunk=0,ieee_virtual_eth=0,port_vlan_id=1,addl_vlan_ids=,mac_addr=26E6B0001002'))
  end

  # data source: own frame
  def test_parse_real
    string = 'lpar_name=dump,lpar_id=1,slot_num=2,state=0,is_required=1,is_trunk=0,ieee_virtual_eth=0,port_vlan_id=1,addl_vlan_ids=,mac_addr=26E6B0001002'
    adapter = VirtualEthAdapter.new(string)
    assert_equal('dump', adapter.lpar_name)
    assert_equal(1, adapter.lpar_id)
    assert_equal(2, adapter.virtualSlotNumber)
    assert_equal(0, adapter.state)
    assert_equal(1, adapter.isRequired)
    assert_equal(0, adapter.trunkPriority)
    assert_equal(0, adapter.isIEEE)
    assert_equal(1, adapter.portVlanID)
    assert_equal('',adapter.additionalVlanIDs)
    assert_equal('26E6B0001002', adapter.macAddress)

    assert_equal(string, adapter.to_s)
  end

  def test_parse_real2
    string = 'lpar_name=vios2,lpar_id=3,slot_num=8,state=1,is_required=1,is_trunk=1,trunk_priority=2,ieee_virtual_eth=0,port_vlan_id=8,addl_vlan_ids=,mac_addr=26E6B0003008'

    adapter = VirtualEthAdapter.new(string)
    assert_equal('vios2', adapter.lpar_name)
    assert_equal(3, adapter.lpar_id)
    assert_equal(8, adapter.virtualSlotNumber)
    assert_equal(1, adapter.state)
    assert_equal(1, adapter.isRequired)
    assert_equal(2, adapter.trunkPriority)
    assert_equal(0, adapter.isIEEE)
    assert_equal(8, adapter.portVlanID)
    assert_equal('',adapter.additionalVlanIDs)
    assert_equal('26E6B0003008', adapter.macAddress)

    assert_equal(string, adapter.to_s)
  end

  def test_validation
    adapter = VirtualEthAdapter.new
    exception = assert_raise(RuntimeError) { adapter.to_s }
    assert_equal('class: VirtualEthAdapter: function: validation, virtualSlotNumber not defined', exception.message)
  end

  def test_compare_adapters_qos_0_none

    adapter1 = VirtualEthAdapter.new('10/0/1//0/0/ETHERNET0//all/none')
    adapter2 = VirtualEthAdapter.new('10/0/1//0/0/ETHERNET0//all/0')
    assert_equal(false, adapter1 == adapter2)

    adapter1 = VirtualEthAdapter.new('10/0/1//0/0/ETHERNET0//all/0')
    adapter2 = VirtualEthAdapter.new('10/0/1//0/0/ETHERNET0//all/0')
    assert_equal(true, adapter1 == adapter2)

    adapter1 = VirtualEthAdapter.new('10/0/1//0/0/ETHERNET0//all/0')
    adapter2 = VirtualEthAdapter.new('10/0/1//0/0/ETHERNET0//all/none')
    assert_equal(false, adapter1 == adapter2)

    adapter1 = VirtualEthAdapter.new('10/0/1//0/0/ETHERNET0//all/none')
    adapter2 = VirtualEthAdapter.new('10/0/1//0/0/ETHERNET0//all/none')
    assert_equal(true, adapter1 == adapter2)

  end

  def test_diff_1

    adapter1 = VirtualEthAdapter.new('10/0/1//0/0/ETHERNET0//all/none')
    adapter2 = VirtualEthAdapter.new('10/0/1//0/0/ETHERNET1//all/0')

    diffs = adapter1.diff(adapter2, 'profile1', 'profile2')
    assert_equal(2, diffs.keys.count)
    assert_equal('qosPiority', diffs.keys[0])
    assert_equal('virtualSwitch', diffs.keys[1])
    assert_equal('none', diffs['qosPiority']['profile1'])
    assert_equal('0', diffs['qosPiority']['profile2'])
    assert_equal('ETHERNET0', diffs['virtualSwitch']['profile1'])
    assert_equal('ETHERNET1', diffs['virtualSwitch']['profile2'])

  end

end