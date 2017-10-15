$LOAD_PATH << File.dirname(__FILE__) + '/../inc'
$LOAD_PATH << File.dirname(__FILE__) + './inc'

test_unit_version=`gem list test-unit`.to_s.scan(/test-unit \((\d\.\d\.\d)/).join
autorunner_file="#{Gem.dir}/gems/test-unit-#{test_unit_version}/lib/test/unit/autorunner.rb"
require autorunner_file if File.exist?(autorunner_file)


require 'HMC/VirtualSerialAdapter'
require 'test/unit'
require 'pp'


class TestVirtualSerialAdapter < Test::Unit::TestCase
 
	def test_base
		adapter = VirtualSerialAdapter.new
		adapter.virtualSlotNmuber=0
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
	
		apdater = VirtualSerialAdapter.new
		apdater.decode('0/server/1/any//any/1')
		
		assert_equal(0, 	     apdater.virtualSlotNmuber)
		assert_equal('server', apdater.clientOrServer)
		assert_equal(1, 	     apdater.supportsHMC)
		assert_equal('any', 	 apdater.remoteLparID)
		assert_equal('',       apdater.remoteLparName)
		assert_equal('any', 	 apdater.remoteSlotNumber)
		assert_equal(1, 	     apdater.isRequired) 		
	end

	def test_compare1

    adapter1 = VirtualSerialAdapter.new('0/server/1/any//any/1')
    adapter2 = VirtualSerialAdapter.new('0/server/1/any//any/0')
    adapter3 = VirtualSerialAdapter.new('0/server/1/any//any/1')

    assert_equal(false, adapter2 == adapter3, 'is adapter2 the same like adapter3' )
    assert_equal(true,  adapter1 == adapter3, 'is adapter1 the same like adapter3' )

  end
end