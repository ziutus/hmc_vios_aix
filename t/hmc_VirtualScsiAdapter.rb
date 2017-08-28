$LOAD_PATH << File.dirname(__FILE__)+"./inc"
$LOAD_PATH << File.dirname(__FILE__)

require 'HMC/VirtualScsiAdapter'
require "test/unit"


class TestVirtualScsiAdapter < Test::Unit::TestCase
 
	def test_base
		adapter = VirtualScsiAdapter.new()
		adapter.virtualSlotNumber 	=1
		adapter.clientOrServer		="client"
		adapter.remoteLparID		=2
		adapter.remoteLparName		="lpar2"
		adapter.remoteSlotNumber	=3
		adapter.isRequired			=1
		
		#virtual-slot-number/client-or-server/[remote-lpar-ID]/[remote-lpar-name]/[remote-slot-number]/is-required
		assert_equal("1/client/2/lpar2/3/1", adapter.to_s() )
	end
	
	def test_bas2
	
	#
		adapter2 = VirtualScsiAdapter.new()
		adapter2.decode("2/server/5/nim1/3/0")
		
		assert_equal(2, 	  adapter2.virtualSlotNumber)
		assert_equal("server",adapter2.clientOrServer)
		assert_equal(5, 	  adapter2.remoteLparID)
		assert_equal("nim1",  adapter2.remoteLparName)
		assert_equal(3, 	  adapter2.remoteSlotNumber)
		assert_equal(0, 	  adapter2.isRequired) 		
	end	
	
	def test_decode_real_adapter
	
		adapter3 = VirtualScsiAdapter.new()
		adapter3.decode("slot_num=8,state=0,is_required=0,adapter_type=server,remote_lpar_id=8,remote_lpar_name=null,remote_slot_num=2")
		
		assert_equal(8, 	  adapter3.virtualSlotNumber)
		assert_equal("server",adapter3.clientOrServer)
		assert_equal(8, 	  adapter3.remoteLparID)
		assert_equal("null",  adapter3.remoteLparName)
		assert_equal(2, 	  adapter3.remoteSlotNumber)
		assert_equal(0, 	  adapter3.isRequired) 		
		
	end
	
	def test_validation_1
	
		adapter4 = VirtualScsiAdapter.new()
	
		exception = assert_raise(RuntimeError) {adapter4.to_s()}
		assert_equal("virtualSlotNumber not defined", exception.message)		

		adapter4 = VirtualScsiAdapter.new()
		adapter4.virtualSlotNumber = "defined"
	
		exception = assert_raise(RuntimeError) {adapter4.to_s()}
		assert_equal("virtualSlotNumber is not number", exception.message)		
		
	end

#	def test_validation_2
#	end
end