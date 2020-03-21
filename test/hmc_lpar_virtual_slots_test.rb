$LOAD_PATH << File.dirname(__FILE__)+'/../lib'
$LOAD_PATH << File.dirname(__FILE__)+'./lib'

require 'test/unit'
require 'HMC/Lpar_virtual_slots'
require 'pp'

class Test_Lpar_virtual_slots < Test::Unit::TestCase

  def test_compare_virtual_slots_tables_fc_different
    slots1 = Lpar_virtual_slots.new(30)
    slots1.profile_name = 'normal_1'
    slots1.virtual_fc_adapters_raw = '21/server/10/bt11/21//0'

    slots2 = Lpar_virtual_slots.new(31)
    slots2.profile_name = 'normal_2'
    slots2.virtual_fc_adapters_raw = '21/server/10/bt11/21//1'

    diff = slots1.diff(slots2, 'virtual_fc_adapters')

    assert_equal(1, diff.size)
  end

  def test_compare_virtual_slots_tables_different_type_of_slots
    slots1 = Lpar_virtual_slots.new(30)
    slots1.profile_name = 'normal_1'
    slots1.virtual_fc_adapters_raw = '21/server/10/bt11/21//0'

    slots2 = Lpar_virtual_slots.new(30)
    slots2.profile_name = 'normal_2'

    vent1 = VirtualEthAdapter.new('21/0/1//0/0')
    slots2.virtual_adapter_add(vent1)

    diff = slots1.diff(slots2, 'virtual_eth_adapters')

    assert_equal(1, diff.size)
    assert_equal('The slot type is VirtualFCAdapter',  diff['VirtualSlot 21']['normal_1'])
    assert_equal('The slot type is VirtualEthAdapter', diff['VirtualSlot 21']['normal_2'])
  end

  # Test data taken from other cases
  def test_none_zero
    slots1 = Lpar_virtual_slots.new(3)
    slots1.profile_name = 'normal_1'
    slots1.virtual_eth_adapters_raw = '2/0/1659//0/0/switcha/facc157c3e20/all/0'

    slots2 = Lpar_virtual_slots.new(3)
    slots2.profile_name = 'normal_2'
    slots2.virtual_eth_adapters_raw = '2/0/1659//0/0/switcha/facc157c3e20/all/none'

    diff_false = slots1.diff(slots2, 'virtual_eth_adapters', false )
    assert_equal(1, diff_false.size)

    diff_true = slots1.diff(slots2, 'virtual_eth_adapters', true )
    assert_equal(0, diff_true.size)
  end


  def test_compare_virtual_slots_tables_different_slots
    slots1 = Lpar_virtual_slots.new(32)
    slots1.profile_name = 'normal_1'
    slots1.virtual_fc_adapters_raw = '21/server/10/bt11/21//0'

    slots2 = Lpar_virtual_slots.new(31)
    slots2.profile_name = 'normal_2'
    slots2.virtual_fc_adapters_raw = '22/server/10/bt11/22//0'

    diff = slots1.diff(slots2, 'virtual_fc_adapters')

    assert_equal(2, diff.size)
    assert_equal('A profile use it: VirtualFCAdapter 21/server/10/bt11/21//0', diff["VirtualSlot 21"]["normal_1"])
    assert_equal("A profile doesn't use slot", diff["VirtualSlot 21"]["normal_2"])

    assert_equal("A profile doesn't use slot", diff["VirtualSlot 22"]["normal_1"])
    assert_equal('A profile use it: VirtualFCAdapter 22/server/10/bt11/22//0', diff["VirtualSlot 22"]["normal_2"])
  end

  def test_compare_virtual_slots_tables_fcs
    slots1 = Lpar_virtual_slots.new(30)
    slots1.profile_name = 'normal_1'
    slots1.virtual_fc_adapters_raw = '21/server/10/bt11/21//0'

    slots2 = Lpar_virtual_slots.new(30)
    slots2.profile_name = 'normal_2'
    slots2.virtual_fc_adapters_raw = '21/server/10/bt11/21//1'

    diff = slots1.diff(slots2, 'virtual_fc_adapters')

    assert_equal(1, diff.size)
    assert_equal(0, diff['VirtualSlot 21 isRequired']['normal_1'])
    assert_equal(1, diff['VirtualSlot 21 isRequired']['normal_2'])
  end

  def test_virtual_eth_adapter
    slots = Lpar_virtual_slots.new(20)

    assert_equal(20, slots.max_virtual_slots)

    vent1 = VirtualEthAdapter.new
    vent1.virtualSlotNumber = 2
    vent1.portVlanID = 1
    vent1.isRequired = 1

    slots.virtual_adapter_add(vent1)
    result = slots.virtual_eth_adapters_to_s
    assert_equal('2/0/1//0/1',result )
  end

  def test_virtual_scsi_adapter
    slots = Lpar_virtual_slots.new(20)

    vscsi1 = VirtualScsiAdapter.new
    vscsi1.virtualSlotNumber = 4
    vscsi1.clientOrServer = 'client'
    vscsi1.remoteLparID = 2
    vscsi1.remoteLparName = 'vios1'
    vscsi1.remoteSlotNumber = 11
    vscsi1.isRequired = 1

    slots.virtual_adapter_add(vscsi1)
    assert('4/client/2/vios1/11/1', slots.virtual_scsi_adapters_to_s)
  end

  def test_virtual_serial_adapter
    slots = Lpar_virtual_slots.new(20)

    vserial = VirtualSerialAdapter.new
    vserial.virtualSlotNumber = 0
    vserial.clientOrServer = 'server'
    vserial.supportsHMC = 1
    vserial.remoteLparID = 'any'
    vserial.remoteLparName = ''
    vserial.remoteSlotNumber = 'any'
    vserial.isRequired = 1

    slots.virtual_adapter_add(vserial)
    #virtual-slot-number/client-or-server/[supports-HMC]/[remote-lpar-ID]/[remote-lpar-name]/[remote-slot-number]/is-required
    assert_equal('0/server/1/any//any/1', slots.virtual_serial_adapters_to_s )
  end

  def test_virtual_fc
    slots = Lpar_virtual_slots.new(20)

    adapter = VirtualFCAdapter.new
    adapter.virtualSlotNumber = 10
    adapter.clientOrServer = 'client'
    adapter.remoteLparID = 20
    adapter.remoteLparName = 'VIOS1-Dilling'
    adapter.remoteSlotNumber = 34
    adapter.wwpn1 = 'c0507602f9ac000a'
    adapter.wwpn2 = 'c0507602f9ac000b'
    adapter.isRequired = 1
    slots.virtual_adapter_add(adapter)

    assert_equal('""10/client/20/VIOS1-Dilling/34/c0507602f9ac000a,c0507602f9ac000b/1""', slots.virtual_fc_adapters_to_s)
  end

  def test_virtual_serial_raw
    slots = Lpar_virtual_slots.new(20)
    slots.virtual_serial_adapters_raw = '0/server/1/any//any/1'
    assert_equal('0/server/1/any//any/1', slots.virtual_serial_adapters_to_s )
  end

  def test_virtual_eth_raw
    slots = Lpar_virtual_slots.new(20)
    slots.virtual_eth_adapters_raw = '32/0/1659//0/0/switcha/facc157c3e20/all/0'
    assert_equal('32/0/1659//0/0/switcha/facc157c3e20/all/0', slots.virtual_eth_adapters_to_s )
  end

  def test_virtual_scsi_raw
    slots = Lpar_virtual_slots.new(20)
    slots.virtual_scsi_adapters_raw = '3/client/2/vios1/32/0'
    assert_equal('3/client/2/vios1/32/0', slots.virtual_scsi_adapters_to_s )
  end

  def test_virtual_fc_raw
    slots = Lpar_virtual_slots.new(20)
    slots.virtual_fc_adapters_raw = '21/server/10/bt11/21//0'
    assert_equal('21/server/10/bt11/21//0', slots.virtual_fc_adapters_to_s )
  end

end