$LOAD_PATH << File.dirname(__FILE__)+"./inc"
$LOAD_PATH << File.dirname(__FILE__)

require 'VIOS/Vhost'
require "test/unit"
require "pp"




class TestViosVtd < Test::Unit::TestCase



	def test_vhost1

		string='vhost2       	      U9111.520.10004BA-V1-C2           0x0000000b'
		vhost = Vhost.new(string)

		pp vhost
		
		assert_equal("vhost2", 			        vhost.name)
		assert_equal("U9111.520.10004BA-V1-C2", vhost.physloc)
		assert_equal("0x0000000b", 			    vhost.client_partition_id)
		assert_equal(11, 			    		vhost.client_partition_id_nice)
	end

end