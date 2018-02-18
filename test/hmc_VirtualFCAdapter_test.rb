$LOAD_PATH << File.dirname(__FILE__) + '/../inc'
$LOAD_PATH << File.dirname(__FILE__) + './inc'

require 'HMC/VirtualFCAdapter'
require 'test/unit'
require 'pp'

class TestVirtualFCAdapter < Test::Unit::TestCase
 
	#example data: http://www-01.ibm.com/support/docview.wss?uid=nas8N1011009
	def test_base
		adapter = VirtualFCAdapter.new
		
		adapter.virtualSlotNumber=10
		adapter.clientOrServer='client'
		adapter.remoteLparID=20
		adapter.remoteLparName='VIOS1-Dilling'
		adapter.remoteSlotNumber=34 
		adapter.wwpn1='c0507602f9ac000a'
		adapter.wwpn2='c0507602f9ac000b'
		adapter.isRequired=1
				
		assert_equal('""10/client/20/VIOS1-Dilling/34/c0507602f9ac000a,c0507602f9ac000b/1""', adapter.to_s)
	end

	#example data: http://www-01.ibm.com/support/docview.wss?uid=nas8N1011009	
	def test_decode

    string = '""10/client/20/VIOS1-Dilling/34/c0507602f9ac000a,c0507602f9ac000b/1""'
		adapter = VirtualFCAdapter.new
		adapter.decode(string)

    assert_equal(string, adapter.to_s)

		#virtual-slot-number/client-or-server/[remote-lpar-ID]/[remote-lpar-name]/remote-slot-number/[wwpns]/is-required	

		assert_equal(10,		adapter.virtualSlotNumber)
		assert_equal('client', 	adapter.clientOrServer)
		assert_equal(20, 		adapter.remoteLparID)
		assert_equal(34, 		adapter.remoteSlotNumber) 
		assert_equal(1,			adapter.isRequired)

		assert_equal('VIOS1-Dilling', 	 adapter.remoteLparName)
		assert_equal('c0507602f9ac000a', adapter.wwpn1)
		assert_equal('c0507602f9ac000b', adapter.wwpn2)
	end


  def test_decode_empty_wwpns

    #https://www.ibm.com/developerworks/community/forums/html/threadTopic?id=77777777-0000-0000-0000-000014412555

    #virtual-slot-number/client-or-server/[remote-lpar-ID]/[remote-lpar-name]/remote-slot-number/[wwpns]/is-required
    string = '21/server/10/bt11/21//0'
    adapter = VirtualFCAdapter.new
    adapter.decode(string)

    assert_equal(string, adapter.to_s)

    assert_equal(21,		adapter.virtualSlotNumber)
    assert_equal('server', 	adapter.clientOrServer)
    assert_equal(10, 		adapter.remoteLparID)
    assert_equal(21, 		adapter.remoteSlotNumber)
    assert_equal(0,			adapter.isRequired)

    assert_equal('bt11', 	 adapter.remoteLparName)
#    assert_equal('c0507602f9ac000a', adapter.wwpn1)
#    assert_equal('c0507602f9ac000b', adapter.wwpn2)
  end


end