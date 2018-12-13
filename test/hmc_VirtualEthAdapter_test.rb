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

  def test_decode2


    adapter2 = VirtualEthAdapter.new
    adapter2.decode('6/1/60//0/0///all/none')
    #virtual-slot-number/is-IEEE/port-vlan-ID/[additional-vlan-IDs]/[trunk-priority]/is-required[/[virtual-switch][/[MAC-address]/[allowed-OS-MAC-addresses]/[QoS-priority]]]

    assert_equal(6, adapter2.virtualSlotNumber, 'Virtual Slot Number')
    assert_equal(1, adapter2.isIEEE, 'is IEEE')
    assert_equal(60, adapter2.portVlanID, 'Port VLan ID')
    assert_equal('',adapter2.additionalVlanIDs, 'Additional Vlan IDs')
    assert_equal(0, adapter2.isTrunk, 'Is Trunk')
    assert_equal(0, adapter2.trunkPriority, 'Trunk Priority')
    assert_equal(0, adapter2.isRequired, 'is required')
    assert_equal('', adapter2.virtualSwitch, 'Virtual Switch name')
    assert_equal('', adapter2.macAddress, 'mac address')
    assert_equal('all', adapter2.allowedOsMacAddresses, 'Allowed Os Mac Addresses')
    assert_equal('none', adapter2.qosPiority, 'QOS Piority')

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

  # test data source: https://www.ibm.com/developerworks/community/forums/html/topic?id=77777777-0000-0000-0000-000014577291
  def test_parse_real3
    string = 'lpar_name=vios1,lpar_id=1,slot_num=12,state=1,is_required=1,is_trunk=1,trunk_priority=1,ieee_virtual_eth=1,port_vlan_id=1,vswitch=ETHERNET0,"addl_vlan_ids=54",mac_addr=FE9F66D5360C'
    adapter = VirtualEthAdapter.new(string)
    assert_equal('vios1', adapter.lpar_name)
  end

  # test data source: https://www.ibm.com/developerworks/community/forums/html/topic?id=77777777-0000-0000-0000-000014577291
  def test_parse_real4
    string = 'lpar_name=clpar5,lpar_id=5,slot_num=2,state=1,is_required=0,is_trunk=0,ieee_virtual_eth=0,port_vlan_id=54,vswitch=ETHERNET0,addl_vlan_ids=,mac_addr=FE9F6044E802'
    adapter = VirtualEthAdapter.new(string)
    assert_equal('clpar5', adapter.lpar_name)
  end

  # test data source: http://www-01.ibm.com/support/docview.wss?uid=isg3T7000527
  def test_parse_real_5
    string = 'lpar_name=p72vio1,lpar_id=1,slot_num=2,state=1,is_required=0, is_trunk=1,trunk_priority=1,ieee_virtual_eth=1, port_vlan_id=1,vswitch=ETHERNET0," addl_vlan_ids=10,11",mac_addr=761FA3934802,allowed_os_mac_addrs=all,qos_priority=none'
    adapter = VirtualEthAdapter.new(string)
    assert_equal('p72vio1', adapter.lpar_name)
  end

  #test data taken from: https://sort.veritas.com/public/documents/sfha/6.1/aix/productguides/html/sfhas_virtualization/ch08s05.htm
  def test_can_parse_real_1
    string='name=lpar05,lpar_id=15,lpar_env=aixlinux,state=Running,resource_config=1,os_version=AIX 7.1 7100-00-00-0000,logical_serial_num=06C3A0PF,default_profile=lpar05,curr_profile=lpar05,work_group_id=none,shared_proc_pool_util_auth=0,allow_perf_collection=0,power_ctrl_lpar_ids=none,boot_mode=norm,lpar_keylock=norm,auto_start=0,redundant_err_path_reporting=0,rmc_state=inactive,rmc_ipaddr=10.207.111.93,time_ref=0,lpar_avail_priority=127,desired_lpar_proc_compat_mode=default,curr_lpar_proc_compat_mode=POWER7,suspend_capable=0,remote_restart_capable=0,affinity_group_id=none'
    adapter = VirtualEthAdapter.new
    assert_equal(false, adapter.can_parse_real?(string))
    assert_equal(false, adapter.can_parse?(string))
  end

  # test data source: http://www-01.ibm.com/support/docview.wss?uid=isg3T7000527
  def test_can_parse_real_5
    string = 'lpar_name=p72vio1,lpar_id=1,slot_num=2,state=1,is_required=0, is_trunk=1,trunk_priority=1,ieee_virtual_eth=1, port_vlan_id=1,vswitch=ETHERNET0," addl_vlan_ids=10,11",mac_addr=761FA3934802,allowed_os_mac_addrs=all,qos_priority=none'
    adapter = VirtualEthAdapter.new
    assert_equal(true, adapter.can_parse_real?(string))
    assert_equal(true, adapter.can_parse?(string))
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

  def test_diff_2

    adapter1 = VirtualEthAdapter.new('10/0/1//0/0/ETHERNET0//all/none')
    adapter2 = VirtualEthAdapter.new('10/0/1//0/0/ETHERNET1//all/0')

    diffs = adapter1.diff(adapter2, 'profile1', 'profile2', false)
    assert_equal(2, diffs.keys.count)
    assert_equal('qosPiority', diffs.keys[0])
    assert_equal('virtualSwitch', diffs.keys[1])
    assert_equal('none', diffs['qosPiority']['profile1'])
    assert_equal('0', diffs['qosPiority']['profile2'])
    assert_equal('ETHERNET0', diffs['virtualSwitch']['profile1'])
    assert_equal('ETHERNET1', diffs['virtualSwitch']['profile2'])

  end


  def test_diff_zero_null_none_1

    adapter1 = VirtualEthAdapter.new('10/0/1//0/0/ETHERNET0//all/none')
    adapter2 = VirtualEthAdapter.new('10/0/1//0/0/ETHERNET1//all/0')

    diffs = adapter1.diff(adapter2, 'profile1', 'profile2', true)
    assert_equal(1, diffs.keys.count)
  end

  def test_diff_zero_null_none_2

    adapter1 = VirtualEthAdapter.new('10/0/1//0/0/ETHERNET0//all/none')
    adapter2 = VirtualEthAdapter.new('10/0/1//0/0/ETHERNET0//all/0')

    diffs = adapter1.diff(adapter2, 'profile1', 'profile2', true)
    assert_equal(0, diffs.keys.count)
  end

end