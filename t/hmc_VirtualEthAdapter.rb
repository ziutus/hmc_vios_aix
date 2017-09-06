$LOAD_PATH << File.dirname(__FILE__)+"./inc"
$LOAD_PATH << File.dirname(__FILE__)

require 'HMC/VirtualEthAdapter'
require "test/unit"


class TestVirtualEthAdapter < Test::Unit::TestCase
 
	def test_base
		adapter = VirtualEthAdapter.new()
		adapter.virtualSlotNumber=6
		adapter.isIEEE=0
		adapter.portVlanID=6 
		adapter.additionalVlanIDs="" 
		adapter.trunkPriority=2
		adapter.isRequired=1
		
		assert_equal("6/0/6//2/1", adapter.to_s() )
	end
	
	def test_decode
	
		adapter2 = VirtualEthAdapter.new()
		adapter2.decode("6/0/6//2/1")

#virtual-slot-number/is-IEEE/port-vlan-ID/[additional-vlan-IDs]/[trunk-priority]/is-required[/[virtual-switch][/[MAC-address]/ 
#[allowed-OS-MAC-addresses]/[QoS-priority]]]
		
		assert_equal(6, 	  adapter2.virtualSlotNumber)
		assert_equal(0,adapter2.isIEEE)
		assert_equal(6, 	  adapter2.portVlanID)
		assert_equal("", 	  adapter2.additionalVlanIDs)
		assert_equal(2,  adapter2.trunkPriority)
		assert_equal(1, 	  adapter2.isRequired) 		
	end	
	
	def test_validation 

		adapter2 = VirtualEthAdapter.new()
	
		exception = assert_raise(RuntimeError) {adapter2.to_s()}
		assert_equal("virtualSlotNumber not defined", exception.message)
	
	end
end