$LOAD_PATH << File.dirname(__FILE__) + '/../inc'
$LOAD_PATH << File.dirname(__FILE__) + './inc'

test_unit_version=`gem list test-unit`.to_s.scan(/test-unit \((\d\.\d\.\d)/).join
autorunner_file="#{Gem.dir}/gems/test-unit-#{test_unit_version}/lib/test/unit/autorunner.rb"
require autorunner_file if File.exist?(autorunner_file)


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
		
		assert_equal('6/0/6//2/1', adapter.to_s() )
	end
	
	def test_decode
	
		adapter2 = VirtualEthAdapter.new()
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

		def test_validation

		adapter = VirtualEthAdapter.new()
	
		exception = assert_raise(RuntimeError) {adapter.to_s()}
		assert_equal('class: VirtualEthAdapter: function: validation, virtualSlotNumber not defined', exception.message)
	
	end
end