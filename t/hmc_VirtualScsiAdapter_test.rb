$LOAD_PATH << File.dirname(__FILE__) + '/../inc'
$LOAD_PATH << File.dirname(__FILE__) + './inc'

test_unit_version=`gem list test-unit`.to_s.scan(/test-unit \((\d\.\d\.\d)/).join
autorunner_file="#{Gem.dir}/gems/test-unit-#{test_unit_version}/lib/test/unit/autorunner.rb"
require autorunner_file if File.exist?(autorunner_file)


require 'HMC/VirtualScsiAdapter'
require 'test/unit'


class TestVirtualScsiAdapter < Test::Unit::TestCase
 
	def test_base
		adapter = VirtualScsiAdapter.new
		adapter.virtualSlotNumber =1
		adapter.clientOrServer		='client'
		adapter.remoteLparID		  =2
		adapter.remoteLparName		='lpar2'
		adapter.remoteSlotNumber	=3
		adapter.isRequired			  =1
		
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
    #
    adapter = VirtualScsiAdapter.new
    adapter.decode('2/server/any//any/0')

    assert_equal(2, 	    adapter.virtualSlotNumber)
    assert_equal('server',adapter.clientOrServer)
    assert_equal('any', 	    adapter.remoteLparID)
    assert_equal('',  adapter.remoteLparName)
    assert_equal('any', 	    adapter.remoteSlotNumber)
    assert_equal(0, 	    adapter.isRequired)

    assert_equal('2/server/any//any/0', adapter.to_s)

  end


  def test_validation_1
	
		adapter = VirtualScsiAdapter.new
	
		exception = assert_raise(RuntimeError) {adapter.to_s
		}
		assert_equal('virtualSlotNumber not defined', exception.message)

	end

	def test_validation_2

	  adapter = VirtualScsiAdapter.new
		adapter.virtualSlotNumber = 'defined'
	
		exception = assert_raise(RuntimeError) {adapter.to_s }
		assert_equal('virtualSlotNumber is not number', exception.message)
	end

#	def test_validation_2
#	end
end