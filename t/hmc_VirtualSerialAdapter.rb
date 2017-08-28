$LOAD_PATH << File.dirname(__FILE__)+"./inc"
$LOAD_PATH << File.dirname(__FILE__)

require 'HMC/VirtualSerialAdapter'
require "test/unit"


class TestVirtualSerialAdapter < Test::Unit::TestCase
 
	def test_base
		adapter = VirtualSerialAdapter.new()
		adapter.virtualSlotNmuber=0
		adapter.clientOrServer="server"
		adapter.supportsHMC=1 
		adapter.remoteLparID="any" 
		adapter.remoteLparName=""
		adapter.remoteSlotNumber="any"
		adapter.isRequired=1
		
		#virtual-slot-number/client-or-server/[supports-HMC]/[remote-lpar-ID]/[remote-lpar-name]/[remote-slot-number]/is-required
		assert_equal("0/server/1/any//any/1", adapter.to_s() )
	end
	
	def test_decode
	
		adapter2 = VirtualSerialAdapter.new()
		adapter2.decode("0/server/1/any//any/1")
		
		assert_equal(0, 	  adapter2.virtualSlotNmuber)
		assert_equal("server",adapter2.clientOrServer)
		assert_equal(1, 	  adapter2.supportsHMC)
		assert_equal("any", 	  adapter2.remoteLparID)
		assert_equal("",  adapter2.remoteLparName)
		assert_equal("any", 	  adapter2.remoteSlotNumber)
		assert_equal(1, 	  adapter2.isRequired) 		
	end	
end