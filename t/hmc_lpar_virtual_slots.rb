$LOAD_PATH << File.dirname(__FILE__)+'/../inc'
$LOAD_PATH << File.dirname(__FILE__)+'./inc'

test_unit_version=`gem list test-unit`.to_s.scan(/test-unit \((\d\.\d\.\d)/).join
autorunner_file="#{Gem.dir}/gems/test-unit-#{test_unit_version}/lib/test/unit/autorunner.rb"
require autorunner_file if File.exist?(autorunner_file)

require 'test/unit'
require 'HMC/Lpar_virtual_slots'
require 'pp'

class Test_Lpar_virtual_slots < Test::Unit::TestCase

  # Called before every test method runs. Can be used
  # to set up fixture information.
  def setup
    # Do nothing
  end

  # Called after every test method runs. Can be used to tear
  # down fixture information.

  def teardown
    # Do nothing
  end

  def test_virtual_eth_adapter
    slots = Lpar_virtual_slots.new(20)

    assert_equal(20, slots.max_virtual_slots)

    vent1 = VirtualEthAdapter.new
    vent1.virtualSlotNumber=2
    vent1.portVlanID=1

    slots.virtual_adapter_add(vent1)
    assert_equal('2/0/1//0/0', slots.adapters_virtual_eth_to_s)
  end

  def test_virtual_scsi_adapter
    slots = Lpar_virtual_slots.new(20)

    vscsi1 = VirtualScsiAdapter.new
    vscsi1.virtualSlotNumber=4
    vscsi1.clientOrServer='client'
    vscsi1.remoteLparID=2
    vscsi1.remoteLparName='vios1'
    vscsi1.remoteSlotNumber=11
    vscsi1.isRequired=1

    slots.virtual_adapter_add(vscsi1)
    assert('4/client/2/vios1/11/1', slots.adapters_virtual_scsi_to_s)
  end

  def test_virtual_serial_adapter
    slots = Lpar_virtual_slots.new(20)

    vserial = VirtualSerialAdapter.new
    vserial.virtualSlotNmuber=0
    vserial.clientOrServer='server'
    vserial.supportsHMC=1
    vserial.remoteLparID='any'
    vserial.remoteLparName=''
    vserial.remoteSlotNumber='any'
    vserial.isRequired=1

    slots.virtual_adapter_add(vserial)
    #virtual-slot-number/client-or-server/[supports-HMC]/[remote-lpar-ID]/[remote-lpar-name]/[remote-slot-number]/is-required
    assert_equal('0/server/1/any//any/1', slots.adapters_virtual_serial_to_s )
  end


  def test_virtual_fc
    slots = Lpar_virtual_slots.new(20)

    adapter = VirtualFCAdapter.new
    adapter.virtualSlotNumber=10
    adapter.clientOrServer='client'
    adapter.remoteLparID=20
    adapter.remoteLparName='VIOS1-Dilling'
    adapter.remoteSlotNumber=34
    adapter.wwpn1='c0507602f9ac000a'
    adapter.wwpn2='c0507602f9ac000b'
    adapter.isRequired=1
    slots.virtual_adapter_add(adapter)

    assert_equal('""10/client/20/VIOS1-Dilling/34/c0507602f9ac000a,c0507602f9ac000b/1""', slots.adapters_virtual_fc_to_s)
  end

  def test_virtual_serial_raw2
    slots = Lpar_virtual_slots.new(20)
    slots.virtual_serial_adapters_raw2 = '0/server/1/any//any/1'
    assert_equal('0/server/1/any//any/1', slots.adapters_virtual_serial_to_s )
  end

  def test_virtual_eth_raw2
    slots = Lpar_virtual_slots.new(20)
    slots.virtual_eth_adapters_raw2 = '32/0/1659//0/0/switcha/facc157c3e20/all/0'
    assert_equal('32/0/1659//0/0/switcha/facc157c3e20/all/0', slots.adapters_virtual_eth_to_s )
  end

  def test_virtual_scsi_raw2
    slots = Lpar_virtual_slots.new(20)
    slots.virtual_scsi_adapters_raw2 = '3/client/2/vios1/32/0'
    assert_equal('3/client/2/vios1/32/0', slots.adapters_virtual_scsi_to_s )
  end

  def test_virtual_fc_raw2
    slots = Lpar_virtual_slots.new(20)
    slots.virtual_fc_adapters_raw2 = '21/server/10/bt11/21//0'
    assert_equal('21/server/10/bt11/21//0', slots.adapters_virtual_fc_to_s )
  end



end